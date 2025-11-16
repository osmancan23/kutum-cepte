part of '../../../reports_view.dart';

class _YearlyReportWidget extends StatelessWidget {
  const _YearlyReportWidget();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: context.general.colorScheme.primaryContainer,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Beylikdüzü - 2025'),
                Expanded(
                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      SizedBox(width: 15),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Toplam Miktar : 120.450 TL',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Dükkan Başına Ortalama : 100 TL',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Toplam Süre: ${1500} saat',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Dağıtılan Kutu',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            '5000',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Dükkan Sayısı',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            '1010',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: context.general.colorScheme.primaryContainer,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tuzla - 2025'),
                Expanded(
                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      SizedBox(width: 15),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Toplam Miktar : 15.450 TL',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Dükkan Başına Ortalama : 100 TL',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Toplam Süre: ${1500} saat',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Dağıtılan Kutu',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            '400',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Dükkan Sayısı',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            '101',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
