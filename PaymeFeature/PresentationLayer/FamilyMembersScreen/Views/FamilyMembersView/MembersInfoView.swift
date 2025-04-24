import SwiftUI

struct MembersInfo: View {
    let participant: UserModel
    let hasCard: Bool

    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(Color.teal.opacity(0.15))
                    .frame(width: 60, height: 60)
                Image(participant.role ? "Parents" : "Child")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(participant.name)
                    .font(.headline)
                Text(participant.number)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text("ПИНФЛ: 518281726700021")
                    .font(.caption)
                    .foregroundColor(.green)
            }

            Spacer()

            if hasCard {
                Image(systemName: "checkmark.circle.fill")
                    .font(.title2)
                    .foregroundColor(.green)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.backgroundC)
                .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
        )
    }
}
