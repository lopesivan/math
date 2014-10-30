#!/usr/bin/env perl

use HP4x::Codec;

$codec = new HP4x::Codec;


$str = $codec->string ("
\<<
    HOME
   'root' PGDIR
\>>");

$str->write_file("dd");
