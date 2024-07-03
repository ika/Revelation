#!/usr/bin/php
<?php

ini_set('register_argc_argv', 0);

if (!isset($argc) || is_null($argc)) {
    exit("Not in CLI mode\n");
}

//-----------------------------------------
// PHP settings
//-----------------------------------------
error_reporting(0);

define("DOCUMENT_ROOT", "{$_SERVER['DOCUMENT_ROOT']}");

//-----------------------------------------
// set variables
//-----------------------------------------
$filename = "about.csv";
$tablename = "about";
$databasename = "about.db";

$file = DOCUMENT_ROOT . "$filename";

define("DATABASENAME", "$databasename");
define("FILE", "$file");
define("TABLENAME", $tablename); // don't change this

class Config
{

    const PATH_TO_SQLITE_FILE = DATABASENAME;
}

class DBConnection
{

    protected static $db;

    public function __construct()
    {


        try {

            self::$db = new PDO('sqlite:' . Config::PATH_TO_SQLITE_FILE);
            self::$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch (PDOException $e) {
            error_log('DBConnection EXCEPTION: ' . $e->getMessage());
        }
    }

    public static function instantiate()
    {

        if (!self::$db) {
            new DBConnection();
        }

        return self::$db;
    }
}

class Install
{

    private $db;
    private $table = TABLENAME;

    public function __construct()
    {

        $this->db = DBConnection::instantiate();
    }

    public function __destruct()
    {
        unset($this->db);
    }

    public function createTable()
    {

        $status = false;

        try {

            $sql = "CREATE TABLE IF NOT EXISTS $this->table (
                id integer primary key,
                h text,
                t text
                )";

            $stmt = $this->db->prepare($sql);
            if ($stmt->execute()) {
                $status = true;
            }
        } catch (PDOException $e) {
            error_log('createTable EXCEPTION: ' . $e->getMessage());
        }
        return $status;
    }

    public function insertData($data = array())
    {

        $status = false;

        try {

            $sql = "INSERT INTO $this->table (h,t) VALUES (:h,:t)";

            $stmt = $this->db->prepare($sql);

            $stmt->bindParam(':h', $data['h']); // text
            $stmt->bindParam(':t', $data['t']); // text

            if ($stmt->execute()) {
                $status = true;
            }
        } catch (PDOException $e) {
            error_log('insertData EXCEPTION: ' . $e->getMessage());
        }

        return $status;
    }
}

//-----------------------------------------
// main loop
//-----------------------------------------

$install = true;

if ($install) {

    // delete old db file
    if (file_exists(DATABASENAME)) {
        unlink(DATABASENAME);
    }

    $sqlite = new Install();
    $sqlite->createTable();
}

$data = array();

echo "---------------------------\n";
echo "Working ....\n";
echo "---------------------------\n";

$range = range(1, 578);

$file = file_get_contents($filename);

$array = explode(']', $file);

for ($x = 0; $x < count($array); $x++) {

    // two parts
    $parts = explode('|', $array[$x]);

    $data['h'] = trim($parts[0]); // text
    $data['t'] = trim($parts[1]); // text

    // Substitute ref number for # ref number
    // foreach ($range as $k => $v) {
    //   $data['t'] = str_replace("$v", "#$v ", $data['t'], $c);
    //  if ($c > 0) {
    //     unset($range[$k]);
    //}
    //}

    // Replace divider
    //$data['t'] = str_replace("]", "", $data['t']);

    // Replace new lines
    //$data['t'] = str_replace("\n", " ", $data['t']);

    // Replace multiple spaces with one
    //$data['t'] = preg_replace('!\s+!', ' ', $data['t']);

    (!$install)
        ? print_r($data)
        : $sqlite->insertData($data);
}

// echo "range count";
// $c = count($range);
// print(" $c\n");

?>
