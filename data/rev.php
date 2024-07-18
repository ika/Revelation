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
$filename = "rev.txt";
$tablename = "rev";
$databasename = "rev.db";

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

            $sql = "INSERT INTO $this->table (t) VALUES (:t)";

            $stmt = $this->db->prepare($sql);

            $stmt->bindParam(':t', $data); // text

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

$file = file_get_contents($filename);

// split on empty line
$array = preg_split("/\n{2,}/",$file);

$data = array();
foreach ($array as $part ){
    $data = preg_split("/\n{2,}/",$part);
#    print_r($data);

#$file = $target_path;
#$fileData = file_get_contents($file) or die('Could not read file!');
#$parts = explode("\n\n", $data);
#$data = array();
#foreach ($parts as $part) {
#    $data[] = explode("\n", $part);
#}
#exit();

#for ($x = 0; $x < count($array[0]); $x++) {

 #   if(str_contains($array[$x], '|')) {

        // two parts
  #      $parts = explode('|', $array[$x]);

    #    $data['h'] = trim($parts[0]); // text
 #       $data['t'] = trim($array[0][$x]); // text

   # } else {
    #    $data['h'] = ''; // text
     #   $data['t'] = trim($array[$x]); // text
   # }

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
  $data[0] = str_replace("\n", " ", $data[0]);




    // Replace multiple spaces with one
    $data[0] = preg_replace('!\s+!', ' ', $data[0]);

    (!$install)
      ? print($data[0])
      : $sqlite->insertData($data[0]);
}

// echo "range count";
// $c = count($range);
// print(" $c\n");

?>
