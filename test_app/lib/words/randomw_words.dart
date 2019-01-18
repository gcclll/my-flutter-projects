import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

// 有状态组件继承自 State 而该 State 来自 RandomWords 类
// RandomWords 类又继承自 StatefulWidget 原生的状态组件。
class RandomWordsState extends State<RandomWords> {

  // 下划线开头，强制变成私有变量
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont
      ),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      // 限定最大的显示数量，不设置则有多少个就会创建多少个
      // itemCount: 5,
      itemBuilder: /* 1 */ (context, i) {
        // 奇数分割线
        if (i.isOdd) return Divider();

        // 取整数部分，返回 integer
        // 如： 1, 2, 3, 4, 5 => 0, 1, 1, 2, 2
        final index = i ~/ 2;

        // 经过取整数，得到的是实际的除去分割线的内容行数的最大索引值
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }

        return _buildRow(_suggestions[index]);
      }
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}
