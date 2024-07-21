import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'widget/default_scaffold.dart';
import 'widget/snack_bar_view.dart';

class DataComparisonScreen extends StatelessWidget {
  const DataComparisonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                // 참고 사이트
                // https://blog.codefactory.ai/flutter/equatable/
                // https://velog.io/@tygerhwang/Flutter-Equatable-1%ED%83%84#equatable-1%ED%83%84
                const bookOne1 = Book(title: '플러터', author: '구글', detail: '플러터 코딩');
                const bookOne2 = Book(title: '플러터', author: 'Google', detail: '플러터 코딩');
                const bookOne3 = Book(title: '플러터', author: '구글', detail: '플러터 코딩');

                const bookTwo1 = Book2(title: '플러터', author: '구글', detail: '플러터 코딩');
                const bookTwo2 = Book2(title: '플러터', author: 'Google', detail: '플러터 코딩');
                const bookTwo3 = Book2(title: '플러터', author: '구글', detail: '플러터 코딩');

                snackBarView(
                  context: context,
                  message: 'BookClass: ${bookOne1 == bookOne2}\n'
                  'BookClass: ${bookOne1 == bookOne3}\n'
                  'Book2Class: ${bookTwo1 == bookTwo2}\n'
                  'Book2Class: ${bookTwo1 == bookTwo3}\n'
                );
              },
              child: const Text('Equatable 비교')
            ),
          ],
        ),
      ),
    );
  }
}

class Book extends Equatable {
  final String title;
  final String author;
  final String detail;

  const Book({ required this.title, required this.author, required this.detail });

  @override
  List<Object?> get props => [title, author, detail];
}

class Book2 extends Equatable {
  final String title;
  final String author;
  final String detail;

  const Book2({ required this.title, required this.author, required this.detail });

  @override
  List<Object?> get props => [];
}
