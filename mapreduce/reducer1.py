import sys

current_word = None
current_count = 0
word = None

for in_line in sys.stdin:
    in_line = in_line.strip()
    word, word_count = in_line.split('\t', 1)
    try:
        word_count = int(word_count)
    except ValueError:
        continue
    # find the number of times a word occurs in a given document
    if current_word == word:
        current_count += word_count
    else:
        if current_word:
            print '%s\t%s' % (current_word, current_count)
        current_count = word_count
        current_word = word
if current_word == word:
    print '%s\t%s' % (current_word, current_count)
