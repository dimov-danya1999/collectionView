import UIKit
class ViewController: UIViewController {
    
    //сделали масиив из изображений
    var imageName = ["1", "2", "3"]
    
    private let collection: UICollectionView = {
        let loyaou = UICollectionViewFlowLayout()
        loyaou.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: loyaou)
        collection.backgroundColor = .systemBlue
        //регистируем коллекцию
        collection.register(ImageCollectionViewCell.self,
                            forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collection)
        collection.delegate = self
        collection.dataSource = self
    }
    //подгон размеров для коллекции, коллекции вью
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collection.frame = view.bounds
    }
}

//создаем ячейки для коллекции, выносить в отдельный файл
class ImageCollectionViewCell: UICollectionViewCell {
    static let identifier = "ImageCollectionViewCell"
    
    //добавляем просмотр изображения
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    //переопределение и просмотр контента
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //мы хотим чтобы изображение занимала ячейку целиком
    override func layoutSubviews() {
        imageView.frame = contentView.bounds
    }
    //подготовит его для повторного использования
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}

//расширяем класс, чтобы сделать количество ячеек и заполнить их данными
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageName.count // количество предметов, секций
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else {
            fatalError()
        }
        cell.imageView.image = UIImage(named: imageName[indexPath.row]) // добавляем изображение
        return cell
    }
    //делаем размер, квадратная клетка
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.size.width / 2) - 2,
                      height: (view.frame.size.width / 2) - 2)
    }
  
    //для работы с картинками, чтобы когда нажимались происходила какая-то связь,
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let configuration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            
            //при нажатии на картинку мы добавляем какие-то действия, картинки или еще чтото
            let open = UIAction(title: "ope",
                                image: UIImage(systemName: "link"),
                                identifier: nil,
                                discoverabilityTitle: nil,
                                attributes: .disabled,
                                state: .off) { _ in
                print("что-то")
            }
            
            return UIMenu(title: "", image: nil, identifier: nil, options: UIMenu.Options.displayInline, children: [open]) 
        }
        return configuration
    }
}

