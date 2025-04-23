import SwiftUI

struct FamilyMembersView: View {
    @ObservedObject var viewModel : FamilyViewModel
    @State private var isShowingSpinner = true
    @State private var showFamilyCardAddSheet: Bool = false
    @State private var showSnackbar: Bool = false
    @State private var snackbarMessage: String = ""
    @State private var snackbarDuration: Double = 3
    
    private var children: [UserModel] {
        viewModel.familyMembers.filter { !$0.role }
    }

    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 20) {

                    if children.isEmpty {
                        Text("No members found")
                            .foregroundColor(.gray)
                            .padding(.top, 100)
                    } else {
                        ForEach(children) { child in
                            let hasCard = viewModel.familyCards.contains {
                                $0.id == child.number
                            }
                            MembersInfo(participant: child, hasCard: hasCard)
                                .padding(.horizontal)
                        }    .sheet(isPresented: $showFamilyCardAddSheet) {
                            FamilyCardAddView(viewModel: viewModel, showSnackbar: $showSnackbar, snackbarMessage: $snackbarMessage)
                                .presentationDetents([.medium])
                                .presentationDragIndicator(.hidden)
                        }
                    }
                }
                .padding(.vertical, 30)
            }
            .background(
                Color(.systemGroupedBackground).ignoresSafeArea()
            )
            .navigationTitle("Дети")
            .navigationBarTitleDisplayMode(.inline)
            .opacity(isShowingSpinner ? 0 : 1)

            if isShowingSpinner {
                ProgressView().scaleEffect(2)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                isShowingSpinner = false
                viewModel.getCurrentUserAndFamily()
            }
        }
    }
}
