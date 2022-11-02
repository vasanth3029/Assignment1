import sys
for in_line in sys.stdin:
    in_line = in_line.strip()
    wordfilename,count=in_line.split('\t',1)
    word,filename=wordfilename.split(' ',1)
    z=word+' '+count;
    print '%s\t%s' % (filename, z)

        
