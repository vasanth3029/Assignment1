import sys
for in_line in sys.stdin:
    in_line = in_line.strip()
    word_file,word_doc_count=in_line.split('\t',1)
    word,file_n=word_file.split(' ',1)
    #for each of the file word combo map 1 to be used in reduce stage
    fin=file_n+' '+word_doc_count+' '+str(1)
    print '%s\t%s' % (word,fin)

        
