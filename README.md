# Common_tools
## cal_primer.R
On Windows:
1. open **Edit environmental variables for your account**, and add **'(???)\R\R-4.0.5\bin\x64'** in Path. (???) is the path where you install R.
1. open File Explorer and choose a location where you want to store the output file, delete file path in the address box, type in **cmd**, and press Enter.
2. type in the following command in the Command prompt
```
Rscript cal_primer.R $reverse complementary sequence of the template strand $start position of mutagenesis region in template strand $end positon of mutagenesis region in template strand
```
For example: 
```
Rscript cal_primer.R ATCCGTACG 3 6
```
