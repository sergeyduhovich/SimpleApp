import Foundation

private struct SongList: Codable {
    let songs: [Song]
}

struct Song: Codable {
    let title: String
    let artist: String
    let year: String
    let webUrl: String
    let imgUrl: String

    enum CodingKeys: String, CodingKey {
        case title, artist, year
        case webUrl = "web_url"
        case imgUrl = "img_url"
    }
}

enum ManagerError: Error {
    case timeout
}

class Manager: FetcherProtocol {
    static let shared = Manager()
    private init() {
        array = parseSongsData()
    }

    private var array: [Song] = []
    internal var failureChance = 0.0

    func parseSongsData() -> [Song] {
        guard let path = Bundle.main.path(forResource: "songs", ofType: "json") else {
            return []
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let songList = try JSONDecoder().decode(SongList.self, from: data)
            print(songList)
            return songList.songs
        } catch {
            print("Data error \(error)")
            return []
        }
    }

    func loadItems(
        offset: Int,
        limit: Int,
        completion: @escaping (Result<[Song], ManagerError>) -> Void
    ) {
        var result: [Song] = []
        let lastElement = min(array.count, offset + limit)
        for i in offset..<lastElement {
            result.append(array[i])
        }

        let random = Double.random(in: 0..<1)
        let timeout = random <= failureChance ? 2000 : 500

        DispatchQueue.main
            .asyncAfter(deadline: DispatchTime.now() + .milliseconds(timeout)) {
                switch random {
                case 0...self.failureChance:
                    completion(.failure(.timeout))
                default:
                    completion(.success(result))
                }
            }
    }
}
