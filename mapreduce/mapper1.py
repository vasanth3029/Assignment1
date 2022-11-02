import sys
import os

stopwords_en= ['a','able','about','across','after','all','almost','also','am','among','an','and','any','are','as','at','be','because','been','but','by',
            'can','cannot','could','dear','did','do','does','either','else','ever','every','for','from','get','got','had','has','have','he','her','hers',
            'him','his','how','however','i','if','in','into','is','it','its','just','least','let','like','likely','may','me','might','most','must','my',
            'neither','no','nor','not','of','off','often','on','only','or','other','our','own','rather','said','say','says','she','should','since','so',
            'some','than','that','the','their','them','then','there','these','they','this','tis','to','too','twas','us','wants','was','we','were','what',
            'when','where','which','while','who','whom','why','will','with','would','yet','you','your'];
# input comes from STDIN (standard input)
for in_line in sys.stdin:
    filename = os.environ["map_input_file"]
    in_line = in_line.strip()
    words = in_line.split()
    #mapping each word for each doc with value 1
    for word in words:
        word=word.lower();
        if word not in stopwords_en:
            word_file=word+' '+filename;
            print '%s\t%s' % (word_file, 1)

        
