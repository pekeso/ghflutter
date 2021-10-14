import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'member.dart';
import 'strings.dart';

class GHFlutter extends StatefulWidget {
  const GHFlutter({Key? key}) : super(key: key);

  @override
  _GHFlutterState createState() => _GHFlutterState();
}

class _GHFlutterState extends State<GHFlutter> {
  final _members = <Member>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle),
      ),
      body: ListView.separated(
        itemCount: _members.length,
        itemBuilder: (BuildContext context, int position) {
          return _buildRow(position);
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
      ),
    );
  }

  Future<void> _loadData() async {
    const dataUrl = 'https://api.github.com/orgs/raywenderlich/members';
    final response = await get(Uri.parse(dataUrl));
    setState(() {
      final dataList = json.decode(response.body) as List;
      for (final item in dataList) {
        final login = item['login'] as String? ?? '';
        final url = item['avatar_url'] as String? ?? '';
        final member = Member(login, url);
        _members.add(member);
      }
    });
  }

  Widget _buildRow(int i) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListTile(
        title: Text(
          '${_members[i].login}',
          style: _biggerFont,
        ),
        leading: CircleAvatar(
          backgroundColor: Colors.green,
          backgroundImage: NetworkImage(_members[i].avatarUrl),
        ),
      ),
    );
  }
}
