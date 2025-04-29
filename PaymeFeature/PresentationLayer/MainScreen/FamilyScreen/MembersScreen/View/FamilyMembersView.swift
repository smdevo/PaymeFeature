import SwiftUI

struct FamilyMembersView: View {
    @ObservedObject var viewModel: FamilyViewModel
    
    @Environment(\.dismiss) private var navDismiss
    
    @State private var isShowingSpinner = true
    @State private var showFamilyCardAddSheet = false
    
    @State private var showSnackbar = false
    @State private var snackbarMessage = ""
    
    @Environment(\.dismiss) var dismiss
    
    let onCardAdded: () -> Void
    
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
                                .onTapGesture {
                                    if !hasCard {
                                        showFamilyCardAddSheet = true
                                    }
                                }
                        }
                        
                    }
                }
                .padding(.vertical, 30)
                .sheet(isPresented: $showFamilyCardAddSheet) {
                    FamilyCardAddView(viewModel: viewModel, onSuccess: {
                        dismiss()
                    })
                    .presentationDetents([.fraction(0.5)])
                    .presentationDragIndicator(.visible)
                }
            }
            .opacity(isShowingSpinner ? 0 : 1)
            
            if isShowingSpinner {
                ProgressView()
                    .scaleEffect(2)
            }
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
        .navigationTitle("Дети")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                isShowingSpinner = false
                viewModel.getCurrentUserAndFamily()
            }
        }
        .sheet(
            isPresented: $showFamilyCardAddSheet,
            onDismiss: {
                viewModel.getCurrentUserAndFamily()
            }
        ) {
            FamilyCardAddView(
                viewModel: viewModel,
                
                onSuccess: {
                    onCardAdded()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            navDismiss()
                        }
                    }
                }
            )
            .presentationDetents([.medium])
            .presentationDragIndicator(.hidden)
        }
        
    }
}
