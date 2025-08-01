import SwiftUI

struct NewsArticle: Identifiable {
    let id = UUID()
    let title: String
    let link: String
    let pubDate: String
}

class GearSortingViewModel: NSObject, ObservableObject, XMLParserDelegate {
    @Published var news = [NewsArticle]()

    private var currentElement = ""
    private var currentTitle = ""
    private var currentLink = ""
    private var currentPubDate = ""
    private var parsingItem = false

    func fetchSportsNews() {
        guard let url = URL(string: "https://feeds.bbci.co.uk/sport/rss.xml") else { return }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print("Ошибка загрузки RSS:", error ?? "нет данных")
                return
            }

            print("data is \(data)")
            
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
        }
        task.resume()
       
    }

    // MARK: - XMLParserDelegate

    func parserDidStartDocument(_ parser: XMLParser) {
        DispatchQueue.main.async {
            self.news.removeAll()
            print("Начинаем парсинг RSS...")
        }
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String,
                namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if elementName == "item" {
            parsingItem = true
            currentTitle = ""
            currentLink = ""
            currentPubDate = ""
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        guard parsingItem else { return }

        switch currentElement {
        case "title":
            currentTitle += string
        case "link":
            currentLink += string
        case "pubDate":
            currentPubDate += string
        default:
            break
        }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String,
                namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let article = NewsArticle(title: currentTitle.trimmingCharacters(in: .whitespacesAndNewlines),
                                      link: currentLink.trimmingCharacters(in: .whitespacesAndNewlines),
                                      pubDate: currentPubDate.trimmingCharacters(in: .whitespacesAndNewlines))
            DispatchQueue.main.async {
                self.news.append(article)
                print("Добавлена новость: \(article.title)")
            }
            parsingItem = false
        }
    }

    func parserDidEndDocument(_ parser: XMLParser) {
        DispatchQueue.main.async {
            print("Парсинг завершён. Всего новостей: \(self.news.count)")
        }
    }

} 