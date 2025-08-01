import SwiftUI

class GearCareNoteViewModel: ObservableObject {
    let contact = GearCareNoteModel()
    @Published var notes: [NoteModel] = []

      private let userDefaultsKey = "careNotes"

      init() {
          loadNotes()
      }

    var totalNotesCount: Int {
         notes.count
     }
     
     var notesThisWeekCount: Int {
         let calendar = Calendar.current
         return notes.filter { note in
             calendar.isDate(note.date, equalTo: Date(), toGranularity: .weekOfYear)
         }.count
     }
     
     var favoritesCount: Int {
         notes.filter { $0.isFav }.count
     }
    
      private func loadNotes() {
          let defaults = UserDefaults.standard
          if let data = defaults.data(forKey: userDefaultsKey),
             let decoded = try? JSONDecoder().decode([NoteModel].self, from: data) {
              notes = decoded
          } else {
              notes = []
          }
      }

      private func saveNotes() {
          let defaults = UserDefaults.standard
          if let encoded = try? JSONEncoder().encode(notes) {
              defaults.set(encoded, forKey: userDefaultsKey)
          }
      }

      func addNote(_ note: NoteModel) {
          notes.append(note)
          saveNotes()
      }

      func toggleFavourite(note: NoteModel) {
          if let index = notes.firstIndex(where: { $0.id == note.id }) {
              notes[index].isFav.toggle()
              saveNotes()
          }
      }
} 