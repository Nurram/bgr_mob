import '../../core_imports.dart';

class CustomDivider extends StatelessWidget {
  final double height;

  const CustomDivider({super.key, this.height = 3});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      color: Colors.grey.shade300,
    );
  }
}
