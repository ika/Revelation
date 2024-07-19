PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "chaps" (
                    id INTEGER PRIMARY KEY,
                    title TEXT DEFAULT '',
                    subtitle TEXT DEFAULT '',
                    doc INTEGER DEFAULT 0,
                    page INTEGER DEFAULT 0,
                    para INTEGER DEFAULT 0
                );
INSERT INTO chaps VALUES(1,'Chapter 1','The revelation of Jesus Christ, which God gave to him, to make known to his servants the things which must soon take place, which he conveyed by sendi',1,0,1);
INSERT INTO chaps VALUES(2,'Chapter 2','To the messenger of the church of Ephesus write: ‘Thus says he who holds the seven stars in his right hand and who walks among the seven lamp-stands o',1,0,9);
INSERT INTO chaps VALUES(3,'Chapter 3','And to the messenger of the church which is at Sardis, write: ‘ This is what the one who has the seven spirits of God and the seven stars says: I know',1,0,14);
INSERT INTO chaps VALUES(4,'Chapter 4','After these things, I looked, and there was a door open into heaven, and a voice, the same one I heard before, like a trumpet speaking to me, saying: ',1,0,17);
INSERT INTO chaps VALUES(5,'Chapter 5','And I saw, in the right hand of the one sitting on the throne, a scroll, written inside and out, and sealed with seven seals. Then I saw a powerful an',1,0,19);
INSERT INTO chaps VALUES(6,'Chapter 6','I watched, and when the Lamb had opened one of the seven seals, I heard one of the four living creatures saying with a voice like thunder: ‘Come.’ And',1,0,22);
INSERT INTO chaps VALUES(7,'Chapter 7','After these things, I saw four angels standing at the four corners of the earth, holding the four winds of the earth, preventing them from blowing upo',1,0,28);
INSERT INTO chaps VALUES(8,'Chapter 8','And when he opened the seventh seal, there was silence in heaven for about half an hour. And I saw seven angels, who stood in the presence of God, and',1,0,31);
INSERT INTO chaps VALUES(9,'Chapter 9','The fifth angel blew his trumpet, and I saw a star that had fallen from heaven onto the earth, and the keys to the pit of the abyss were given to him.',1,0,37);
INSERT INTO chaps VALUES(10,'Chapter 10','And I saw another powerful angel descending from heaven, enveloped in a cloud, with a rainbow above his head, and his face was like the sun, and his f',1,0,44);
INSERT INTO chaps VALUES(11,'Chapter 11','A reed, similar to a rod, was given to me, saying: ‘Rise and measure the temple of God, and the altar and the worshippers in it. But the reception hal',1,0,45);
INSERT INTO chaps VALUES(12,'Chapter 12','And a great sign appeared in heaven: a woman, clothed in the sun, with the moon under her feet, and upon her head, a crown of twelve stars; and she wa',1,0,50);
INSERT INTO chaps VALUES(13,'Chapter 13','And I saw a creature coming up out of the sea, having ten horns and seven heads; and upon its horns, seven diadems, and upon its heads, blasphemous na',1,0,54);
INSERT INTO chaps VALUES(14,'Chapter 14','And I looked, and I saw the Lamb standing on Mount Zion, and with him one hundred and forty four thousand, all having his name and the name of his Fat',1,0,59);
INSERT INTO chaps VALUES(15,'Chapter 15','And I saw a great and wondrous sign in heaven: seven angels having the seven last plagues, for with these, the wrath of God is complete. And I saw som',1,0,64);
INSERT INTO chaps VALUES(16,'Chapter 16','And I heard a great voice from the temple, saying to the seven angles: ‘Go, and pour out the seven bowls of the wrath of God on the land.’ And the fir',1,0,66);
INSERT INTO chaps VALUES(17,'Chapter 17','And one of the seven angels, who had the seven bowls, came to me and said: ‘Come, and I will show you the damnation of the great prostitute, who sat u',1,0,79);
INSERT INTO chaps VALUES(18,'Chapter 18','After this I saw the other angel descending from heaven, having great power; and the earth was lit up by his brightness. And he shouted with a loud vo',1,0,80);
INSERT INTO chaps VALUES(19,'Chapter 19','After this I heard something like the voices of a great multitude in heaven, saying: ‘Hallelujah! Salvation and glory and power to our God, for his ju',1,0,83);
INSERT INTO chaps VALUES(20,'Chapter 20','And I saw the angel descending from heaven having in his hand the keys to the abyss and a great chain. He took hold of the dragon, that ancient serpen',1,0,88);
INSERT INTO chaps VALUES(21,'Chapter 21','And I saw a new heaven and a new earth, for the first heaven and the first earth were no more, and there was no more sea. And I saw the holy city, the',1,0,92);
INSERT INTO chaps VALUES(22,'Chapter 22','And he showed me the river of the water of life, splendid like crystal, proceeding from the throne of God and the Lamb. In the middle of the street, a',1,0,95);
COMMIT;
