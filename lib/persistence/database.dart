import 'package:major_kill_minis/objects/major_mini.dart';

class PersistentDatabase {
  static List getProducts() {
    return [
      MajorMini(
          name: 'SETTRON THE UNDYING', description: 'An ancient King of the oldest empire. Settron\'s only regret in death is that he was unable to conquer the entire galaxy within only one lifespan. However with the awakening of the undying legions, he has returned in a new living metal body. Ready to finish what he started 60 million years ago..',
          price: 33.00, size: 'Larger than a normal Necron, on par with the Silent King',
          image: 'https://cdn.shopify.com/s/files/1/0655/6283/7245/products/SetronSettraheroImage1_1000x.jpg?v=1667739714', base: 'SOME BASE', recommendedProxy: 'SOME PROXY', link: 'https://www.sizibamthandazo.dev'
      ),
      MajorMini(
          name: 'MASTER OF THE SPACE LIONS', description: 'The Master of the Space Lions. This beat of a warrior has been through hell and back. Punished by the Inquisitors for speaking up against their crimes, he has fought for centuries to maintain his chapters honour and keep them from extinction.\n\n\nComes with both a helmet and helmetless variant',
          price: 28.00,
          size: 'Same size as Gravis Primaris', image: 'https://cdn.shopify.com/s/files/1/0655/6283/7245/products/HQ_Helmet_1000x.jpg?v=1667217025', base: 'SOME BASE', recommendedProxy: 'CHOAS SPACE MARINES', link: 'https://www.sizibamthandazo.dev'
      )

    ];
  }
}