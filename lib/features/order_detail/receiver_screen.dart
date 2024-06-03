import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/models/privileges_response.dart';
import 'package:bgr_logistik/models/receiver_data.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class ReceiverScreen extends StatefulWidget {
  final ReceiverData? receiverData;
  final List<PrivilegeDatum> privileges;
  final String selectedPrivilege;

  const ReceiverScreen({
    super.key,
    required this.receiverData,
    required this.privileges,
    required this.selectedPrivilege,
  });

  @override
  State<ReceiverScreen> createState() => _ReceiverScreenState();
}

class _ReceiverScreenState extends State<ReceiverScreen> {
  final key = GlobalKey<FormState>();
  final nameCtr = TextEditingController();
  final addressCtr = TextEditingController();
  final phoneCtr = TextEditingController();

  String selectedPrivilege = '';

  @override
  void initState() {
    selectedPrivilege = widget.selectedPrivilege;

    if (widget.receiverData != null) {
      nameCtr.text = widget.receiverData!.name;
      phoneCtr.text = widget.receiverData!.phone;
      addressCtr.text = widget.receiverData!.address;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Penerima'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: key,
          child: ListView(
            children: [
              CustomTextFormField(
                controller: nameCtr,
                hint: 'Nama',
              ),
              CustomTextFormField(
                controller: addressCtr,
                hint: 'Alamat',
              ),
              CustomTextFormField(
                controller: phoneCtr,
                hint: 'Nomor Telepon',
                inputType: TextInputType.phone,
              ),
              Obx(
                () => DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: Text(
                      'Pilih Privilege',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    items: widget.privileges
                        .map((item) => DropdownMenuItem<String>(
                              value: item.name,
                              child: Text(
                                item.name,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                        .toList(),
                    value: selectedPrivilege,
                    onChanged: (String? value) {
                      setState(() {
                        selectedPrivilege = value ?? widget.privileges[0].name;
                      });
                    },
                    buttonStyleData: const ButtonStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      height: 40,
                      width: 140,
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 80),
              LoadingButton(
                text: 'Tambahkan',
                onPressed: () {
                  if (!key.currentState!.validate()) return;

                  Get.back(
                    result: ReceiverData(
                        name: nameCtr.text,
                        address: addressCtr.text,
                        phone: phoneCtr.text,
                        privilegeId: 1,
                        privilegeName: selectedPrivilege),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
