import pandas as pd
ham=pd.read_csv("/home/vasanth3029/ham_messages.csv")


path="/home/vasanth3029/tfidf/ham_input/"
for i in range(len(ham)):
    s=ham.iloc[i]['sender']
    with open(path+str(s)+".txt", "a") as f:
        f.write(ham.iloc[i]['message'])
        
ham=pd.read_csv("/home/vasanth3029/spam_messages.csv")


path="/home/vasanth3029/tfidf/spam_input/"
for i in range(len(ham)):
    s=ham.iloc[i]['sender']
    with open(path+str(s)+".txt", "a") as f:
        f.write(ham.iloc[i]['message'])