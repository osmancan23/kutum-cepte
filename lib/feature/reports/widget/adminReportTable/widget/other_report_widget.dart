part of '../../../reports_view.dart';

@immutable
// ignore: must_be_immutable, unused_element
class _OtherReportWidget extends StatelessWidget {
  _OtherReportWidget();
  bool isChooseDate = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CustomText('Başlangıç Tarihi'),
          DateSelectWidget(
            onChange: (value) {
              // Başlangıç tarihi seçildiğinde yapılacak işlemler
            },
          ),
          SizedBox(height: 20.h),
          const CustomText('Bitiş Tarihi'),
          DateSelectWidget(
            onChange: (value) {
              // Bitiş tarihi seçildiğinde yapılacak işlemler
              value != null ? isChooseDate = true : isChooseDate = false;
            },
          ),
          SizedBox(height: 20.h),
          ButtonWidget(
            text: 'Raporu Oluştur',
            onTap: () {
              if (isChooseDate) {
                // Rapor oluşturulacak
              } else {
                // Tarih seçilmedi uyarısı
              }
            },
          ),
        ],
      ),
    );
  }
}
