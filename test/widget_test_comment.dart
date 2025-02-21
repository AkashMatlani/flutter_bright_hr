import 'package:flutter/material.dart';
import 'package:flutter_bright_hr/screens/comment_item.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bright_hr/models/comment.dart';

void main() {
  testWidgets('Should display comments in a ListView with separators', (WidgetTester tester) async {
    // Arrange: Create a list of sample comments.
    final comments = [
      Comment(
        name: 'id labore ex et quam laborum',
        body: 'laudantium enim quasi est quidem magnam\n'
            'voluptate ipsam eos tempora quo necessitatibus\n'
            'dolor quam autem quasi reiciendis et nam sapiente accusantium',
      ),
      Comment(
        name: 'quo vero reiciendis velit similique earum',
        body: 'est natus enim nihil est dolore omnis voluptatem numquam\n'
            'et omnis occaecati quod ullam at voluptatem error expedita pariatur\n'
            'nihil sint nostrum voluptatem reiciendis et',
      ),
      Comment(
        name: 'odio adipisci rerum aut animi',
        body: 'quia molestiae reprehenderit quasi aspernatur\n'
            'aut expedita occaecati aliquam eveniet laudantium\n'
            'omnis quibusdam delectus saepe quia accusamus maiores nam est\n'
            'cum et ducimus et vero voluptates excepturi deleniti ratione',
      ),
      Comment(
        name: 'alias odio sit',
        body: 'non et atque\n'
            'occurrat consequatur quibusdam saepe culpa',
      ),
    ];

    // Act: Build the widget tree and pump it into the tester.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ListView.separated(
            itemCount: comments.length,
            itemBuilder: (context, index) {
              return CommentItem(comment: comments[index]);
            },
            separatorBuilder: (context, index) => Divider(),
          ),
        ),
      ),
    );

    // Assert: Verify that all comments are displayed.
    expect(find.text('id labore ex et quam laborum'), findsOneWidget);
    expect(find.text('quo vero reiciendis velit similique earum'), findsOneWidget);
    expect(find.text('odio adipisci rerum aut animi'), findsOneWidget);
    expect(find.text('alias odio sit'), findsOneWidget);

    // Assert: Verify that the separators (Divider) exist between the items.
    expect(find.byType(Divider), findsNWidgets(comments.length - 1));
  });
}
