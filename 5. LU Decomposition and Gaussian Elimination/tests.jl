include("blocksys.jl")
using .blocksys

# testowanie dla danych  folderze
function testDirectory(dirName)
    for file in readdir("data")
        folderName = "data/"*file
        TestGauss(folderName)
        TestLU(folderName)
    end
end

# przykład testu
folderName = "data/T500000"
# TestGauss(folderName)
TestLU(folderName)
