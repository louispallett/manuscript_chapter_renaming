# Renaming Chapter Files
A small script written in bash to rename .docx files in accordance with publication guidelines.

## Purpose
In my current role, I receive manuscripts from authors divided by chapter. These chapters have to be strictly named in the format "[chapter number]_Chapter[chapter number]" - i.e. "01_Chapter 1". 

However, often authors will submit the chapters numbered, but not in this format - i.e. "Chapter 1" or "1 Chapter 1". If a book only has 5 or 6 chapters, this is very easy to just rename the files using the file system (right-click > rename), but for books with 20 or 30 chapters, this can be a little tedious.

This simple shell script takes a directory of files and renames them according to the stated format. 

## Installation

You can download the file by simplying copying the rename.sh file into a text editor and saving it. Alternatively, you can run the git lone and HTTPS commands:

```sh
git clone https://github.com/louispallett/manuscript_chapter_renaming.git
```

This will clone the repository into your local environment. You'll then want to go into the directory and compile the rename.sh file (if you've just copied the code into your text editor, save the file as rename.sh, then go into terminal, navigate to the directory the file is in, and type the last line below):

```sh
cd manuscript_chapter_renaming/
chmod +x rename.sh
```

This will make the rename.sh file executable. You can now execute the file with the following command.

```sh
./rename.sh
```

#### Usage: ./rename_files.sh directory startingValue

This programme requires two command line arguments: the directory you wish to rename the files and the starting number you want the first file to be renamed to. For example:

```sh
./rename.sh myBook/ 1
```

... would rename all the files in the myBook directory and would start from '1' - i.e. the first file would be named "01_Chapter 1", the second "01_Chapter 2", etc.

**NOTE**: it is recommended you back-up all files in case of any unforseen errors.

If you wish to edit the name of the chapters, you can do so by editing line 52:

```sh
new_name=$(printf "%02d_Chapter %d.%s" "$i" "$i" "$extension")
```

## Limitations

- This is a _Bash_ script, so it will only work on Linux distros and Mac.
- The programme assumes the files you want to change are already in order - if they are not, the programme will write over the file names regardless.
- Because of how the programme (and computers more generally) read numbers, it will read "11" as coming just after "1", as it sees them as "1.1" and "1.0". So, the first 9 chapters should be done seperately, followed by executing the script again for the remaining chapters. This means to rename anything greater than 9 chapters, you will need to run the script twice - like so:

```sh
# Just place the first 9 chapters in the directory
./rename.sh myBook/ 1
# Then move all of these chapters into another directory and get the remaining chapters
mv myBook/* done/
mv remaining-chapters/* myBook/
# Finally, execute the script again, but start from 10
./rename.sh myBook/ 10
# And move the rest into your final directory!
mv myBook/* done/
```