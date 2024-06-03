import '../../core_imports.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String message;
  final Function() onConfirm;

  const CustomAlertDialog({
    super.key,
    required this.title,
    this.message = 'Apakah anda yakin?',
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style:
                  StyleText.textRed(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Divider(),
            TextButton(
              onPressed: onConfirm,
              child: const Text(
                'Ya',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
