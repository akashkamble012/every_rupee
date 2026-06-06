void main() { List<String> h = ['a']; List<List<dynamic>> r = [['b']]; List<List<dynamic>> c = [h, ...r]; print(c); }
