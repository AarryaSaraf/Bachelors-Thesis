grammar = {
    '0':['(0)0', '()', '(0)', '()0']
    }

class State:

    def __init__(self, path, rule, i, origin):
        self.rule = rule
        self.path = path
        self.i = i
        self.origin = origin
        self.parse = path[:i]
        self.nparse = path[i:]

    def __eq__(self, other):
        return  (self.rule == other.rule and self.path == other.path and self.i == other.i and self.origin == other.origin)

    def __hash__(self):
        return hash((self.rule, self.path, self.i, self.origin))

    def canComplete(self):
        return self.i == len(self.path)
    
    def canPredict(self):
        return (not self.canComplete()) and self.nparse[0].isdigit()
    
    def canScan(self, symbol):
        return self.nparse and (not self.canComplete()) and self.nparse[0] == symbol
    
    def __repr__(self):
        return f'Rule = {self.rule} \nPath = {self.path} \norigin = {self.origin} \nDot = {self.i} \n \n'
     
    def __str__(self):
        return f'Rule = {self.rule} \nPath = {self.path} \norigin = {self.origin} \nDot = {self.i} \n \n' 
    
def parse(st):
    chart = [set() for _ in range(len(st)+1)]
    for path in grammar['0']:
        chart[0].add(State(path, 0, 0, 0))
    k=0
    while k < (len(st)):
        l1 = len(chart[k])
        predict(k, chart)
        complete(k, chart)
        if(len(chart[k])>l1):
            continue
        scan(st[k], k, chart)
        k+=1
    for state in chart[len(st)]:
        if state.canComplete and state.rule == 0:
            return True
    return False

def predict(i, chart):
    k=0
    while(k<len(chart[i])):
        for k in range(k,len(chart[i])+1):
            if(k==len(chart[i])):
                break
            state = list(chart[i])[k]
            if state.canPredict():
                next = state.nparse[0]
                for path in grammar[next]:
                    chart[i].add(State(path, int(next), 0, i))

def scan(symbol, i , chart):
    for state in chart[i]:
        if state.canScan(symbol):
            chart[i+1].add(State(state.path, state.rule, state.i+1, state.origin))

def complete(i, chart):
    k=0
    while(k<len(chart[i])):
        for k in range(k, len(chart[i])+1):
            if(k==len(chart[i])):
                break
            state = list(chart[i])[k]
            if state.canComplete():
                for estate in chart[state.origin]:
                    if estate.nparse and estate.nparse[0] == str(state.rule):
                        chart[i].add(State(estate.path, estate.rule, estate.i+1, estate.origin))

def main():
    s = "(()())()()"
    print(parse(s))
    
main()
