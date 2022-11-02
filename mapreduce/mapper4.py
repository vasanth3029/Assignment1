import sys
from math import log10

lines=list()
files=list()
for line in sys.stdin:
    line = line.strip()
    lines.append(line)
    word_file,wc_dc_tc=line.split('\t',1)
    word,file_nm=word_file.split(' ',1)
    files.append(str(file_nm))

### get total number of files    
tot_docs = len(list(set(files)))

#calc tfidf for all words in all docs
for line in lines:    
    word_file,wc_dc_tc=line.split('\t',1)
    wc,dwc,dc=wc_dc_tc.split(' ',2)
    wc=float(wc)
    dwc=float(dwc)
    dc=float(dc)
    tfidf= (wc/dwc)*log10(tot_docs/dc)
    print '%s\t%s' % (word_file,tfidf)

        
