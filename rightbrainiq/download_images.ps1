$base = "https://rightbrainiq.com/wp-content/uploads"
$dir = "assets/images/products"
New-Item -ItemType Directory -Path $dir -Force | Out-Null

$urls = @(
  # Categories
  "$base/2025/11/SMART-START-CARDS-600x600.jpg",
  "$base/2025/10/Connect-CARDS-600x600.jpg",
  "$base/2025/10/GEO-card-Front-image-600x600.webp",
  "$base/2025/10/Mini-globe-cards-Front-Image-600x600.webp",
  "$base/2025/10/JUMBO-CARDS-1-600x600.jpg",
  "$base/2025/10/High-Con-1-600x600.jpg",
  # Smart Start Cards
  "$base/2025/08/FLAGS-600x600.jpg", "$base/2025/09/flag-1-600x600.jpg",
  "$base/2025/08/ANIMALS-600x600.jpg", "$base/2025/09/ANIMALS-1-600x600.jpg",
  "$base/2025/08/FRUITS-600x600.jpg", "$base/2025/08/FRUITS-1-600x600.webp",
  "$base/2025/08/VEGETABLES-600x600.jpg", "$base/2025/08/VEGETABLES-1-600x600.webp",
  "$base/2025/08/BIRDS-600x600.jpg", "$base/2025/09/Birds-1-600x600.jpg",
  "$base/2025/08/FLOWERS-600x600.jpg", "$base/2025/09/FLOWERS-1-600x600.jpg",
  "$base/2025/08/TRANSPORT-600x600.jpg",
  "$base/2025/08/COLOURS-600x600.jpg", "$base/2025/09/COLOURS-3-600x600.jpg",
  "$base/2025/08/SHAPES-600x600.jpg", "$base/2025/08/SHAPES-2-600x600.jpg",
  "$base/2025/08/Alphabets-600x600.jpg", "$base/2025/09/ALPHABETS-1-600x600.jpg",
  "$base/2025/08/PROFESSION-600x600.jpg", "$base/2025/08/PROFESSIONS-1-600x600.jpg",
  "$base/2025/08/MONTHS-AND-DAYS-600x600.jpg", "$base/2025/09/DAYS-AND-MONTH-1-600x600.jpg",
  "$base/2025/08/PARTS-OF-THE-BODY_-600x600.jpg", "$base/2025/08/PARTS-OF-THE-BODY-1-600x600.webp",
  "$base/2025/08/SPORTS-600x600.jpg", "$base/2025/08/2-600x600.jpg",
  "$base/2025/08/HOME-APPLIANCES-600x600.jpg", "$base/2025/08/HOME-APPLIANCES-1-600x600.jpg",
  "$base/2025/08/RED-THINGS-600x600.jpg", "$base/2025/08/RED-THINGS-1-600x600.jpg",
  "$base/2025/08/GREEN-THINGS-600x600.jpg", "$base/2025/09/GREEN-THINGS-1-600x600.jpg",
  "$base/2025/08/BLUE-THINGS-600x600.jpg", "$base/2025/09/BLUE-THINGS-1-600x600.jpg",
  "$base/2025/08/YELLOW-THINGS-600x600.jpg", "$base/2025/08/Yellow-things-1-600x600.jpg",
  "$base/2025/08/SEA-TRANSPORT-600x600.jpg", "$base/2025/08/SEA-TRANSPORT-1-1-600x600.jpg",
  "$base/2025/08/ACCESSORIES-600x600.jpg", "$base/2025/09/ACCESORIES-1-600x600.jpg",
  "$base/2025/08/ACTION-VERB-1-600x600.jpg", "$base/2025/08/ACTION-VERBS-1-600x600.jpg",
  "$base/2025/08/AIR-TRANSPORT-600x600.jpg", "$base/2025/09/AIR-TRANSPORT-1-600x600.jpg",
  "$base/2025/08/ARMY-AND-MILTARY-VOCABULARY-600x600.jpg", "$base/2025/09/ARMY-AND-MILITARY-VOCABULARY-1-600x600.jpg",
  "$base/2025/09/ARTIC-ANIMALS-600x600.jpg", "$base/2025/09/ARTIC-ANIMALS-1-600x600.jpg",
  "$base/2025/08/BABY-ANIMALS-600x600.jpg", "$base/2025/09/BABY-ANIMALS-2-600x600.jpg",
  "$base/2025/08/BODY-POSITION-600x600.jpg", "$base/2025/09/BODY-POSITION-1-600x600.jpg",
  "$base/2025/08/BUSINESS_-600x600.jpg", "$base/2025/09/BUSINESS-3-600x600.jpg",
  "$base/2025/08/CAR-LOGOS-600x600.jpg", "$base/2025/09/CAR-LOGOS-1-600x600.jpg",
  "$base/2025/08/TYPES-OF-CHEESE-600x600.jpg",
  "$base/2025/08/TYPES-OF-CHILLI-1-600x600.jpg", "$base/2025/09/CHILLI-VARIETIES-1-600x600.jpg",
  "$base/2025/08/COMMON-PLACES-600x600.jpg", "$base/2025/09/COMMON-PLACES-1-600x600.jpg",
  "$base/2025/08/CONTINENTS-AND-SOLAR-SYSTEM-600x600.jpg", "$base/2025/08/CONTINENTS-1-600x600.jpg",
  "$base/2025/08/CURRENCY-600x600.jpg", "$base/2025/09/CURRENCY-1-600x600.jpg",
  # Connect Cards
  "$base/2025/10/Connect-Cards-1-1-600x600.webp", "$base/2025/10/Connect-Card-1-1-600x600.jpg",
  "$base/2025/10/Connect-Cards-2-1-600x600.webp", "$base/2025/10/Connect-Card-2-1-600x600.jpg",
  "$base/2025/10/Connect-Cards-4-1-600x600.webp", "$base/2025/10/Connect-Card-3-2-600x600.jpg",
  "$base/2025/10/Connect-Cards-5-1-600x600.webp", "$base/2025/10/Connect-Card-4-1-600x600.jpg",
  "$base/2025/10/Connect-Cards-6-1-600x600.webp", "$base/2025/10/Connect-Card-5-1-600x600.jpg",
  "$base/2026/01/Connect-Cards-temphlet-6-600x600.jpg",
  # GEO Cards
  "$base/2025/09/AIRPORT-GEO-CARD-600x600.webp", "$base/2025/09/AIRPORT-1-600x600.webp",
  "$base/2025/09/AMUSEMENT-PARK-GEO-CARD-600x600.webp", "$base/2025/09/AMUSEMENT-PARK-1-600x600.webp",
  "$base/2025/09/Art-Gallery-GEO-CARD-600x600.webp", "$base/2025/09/ART-GALLERY-1-600x600.webp",
  "$base/2025/09/BAKERY-GEO-CARD-600x600.webp", "$base/2025/09/BAKERY-1-600x600.webp",
  "$base/2025/09/BANK-GEO-CARD-600x600.webp", "$base/2025/09/BANK-1-600x600.webp",
  "$base/2025/09/BEACH-GEO-CARD-600x600.webp", "$base/2025/09/BEACH-1-600x600.webp",
  "$base/2025/09/BEDROOM-GEO-CARD-600x600.webp", "$base/2025/09/BEDROOM-1-600x600.webp",
  "$base/2025/09/BOOK-STORE-GEO-CARD-600x600.webp", "$base/2025/09/BOOK-STORE-2-600x600.webp",
  "$base/2025/09/CAFE-GEO-CARD-600x600.webp", "$base/2025/09/CAFE-1-600x600.webp",
  "$base/2025/09/CHURCH-GEO-CARD-600x600.webp", "$base/2025/09/CHURCH-1-600x600.webp",
  "$base/2025/09/CINEMA-THEATRE-GEO-CARD-600x600.webp", "$base/2025/09/CINEMA-THEATRE-1-600x600.webp",
  "$base/2025/09/CLOTHING-STORE-GEO-CARD-600x600.webp", "$base/2025/09/CLOTHING-STORE-1-600x600.webp",
  "$base/2025/09/COURT-GEO-CARD-600x600.webp", "$base/2025/09/COURT-1-600x600.webp",
  "$base/2025/09/DENTAL-HOSPITAL-GEO-CARD-600x600.webp", "$base/2025/09/DENTAL-HOSPITAL-1-1-600x600.webp",
  "$base/2025/09/Exhibition-GEO-CARD-600x600.webp", "$base/2025/09/EXHIBITION-1-600x600.webp",
  "$base/2025/09/FARMGEO-CARD-600x600.webp", "$base/2025/09/FARM-1-600x600.webp",
  "$base/2025/09/fire-station-GEO-CARD-600x600.webp", "$base/2025/09/FIRE-STATION-1-600x600.webp",
  "$base/2025/09/FLEA-MARKET-CARD-1-600x600.webp", "$base/2025/09/FLEA-MARKET-2-600x600.webp",
  "$base/2025/09/GARAGE-GEO-CARD-600x600.webp", "$base/2025/09/GARAGE-1-600x600.webp",
  "$base/2025/09/Garden-GEO-CARD-600x600.webp", "$base/2025/09/GARDEN-1-600x600.webp",
  "$base/2025/09/HOSPITAL-GEO-CARD-600x600.webp", "$base/2025/09/HOSPITAL-1-600x600.webp",
  "$base/2025/09/LIBRARY-GEO-CARD-600x600.webp", "$base/2025/09/LIBRARY-1-600x600.webp",
  "$base/2025/09/MALL-GEO-CARD-600x600.webp", "$base/2025/09/MALL-1-600x600.webp",
  "$base/2025/09/MOSQUE-GEO-CARD-600x600.webp", "$base/2025/09/MOSQUE-1-600x600.webp",
  "$base/2025/09/MUSEUM-GEO-CARD-600x600.webp", "$base/2025/09/MUSEUM-1-600x600.webp",
  "$base/2025/09/PARK-GEO-CARD-600x600.webp", "$base/2025/09/PARK-1-600x600.webp",
  # Mini Globe Cards
  "$base/2025/09/AFGHANISTAN-Card-600x600.webp", "$base/2025/09/AFGHANISTAN-1-600x600.webp",
  "$base/2025/09/AUSTRALIA-Card-1-600x600.webp", "$base/2025/09/AUSTRALIA-1-600x600.webp",
  "$base/2025/09/BRAZIL-Card-1-600x600.webp", "$base/2025/09/BRAZIL-1-600x600.webp",
  "$base/2025/09/CANADA-Card-1-600x600.webp", "$base/2025/09/CANADA-1-600x600.webp",
  "$base/2025/09/CHINA-Card-1-600x600.webp", "$base/2025/09/CHINA-1-600x600.webp",
  "$base/2025/09/EGYPT-Card-1-600x600.webp", "$base/2025/09/EGYPT-1-600x600.webp",
  "$base/2025/09/FRANCE-Card-1-600x600.webp", "$base/2025/09/FRANCE-1-600x600.webp",
  "$base/2025/09/GERMANY-Card-1-600x600.webp", "$base/2025/09/GERMANY-1-600x600.webp",
  "$base/2025/09/INDIA-Card-1-600x600.webp", "$base/2025/09/INDIA-1-600x600.webp",
  "$base/2025/09/JAPAN-Card-1-600x600.webp", "$base/2025/09/JAPAN-1-600x600.webp",
  "$base/2025/09/RUSSIA-Card-1-600x600.webp", "$base/2025/09/RUSSIA-1-600x600.webp",
  "$base/2025/09/UK-Card-1-600x600.webp", "$base/2025/09/UK-1-600x600.webp",
  "$base/2025/09/USA-Card-1-600x600.webp", "$base/2025/09/USA-1-600x600.webp",
  "$base/2025/09/ITALY-Card-1-600x600.webp", "$base/2025/09/ITALY-1-600x600.webp",
  "$base/2025/09/SOUTH-AFRICA-Card-1-600x600.webp", "$base/2025/09/SOUTH-AFRICA-1-600x600.webp",
  "$base/2025/09/SINGAPORE-Card-1-600x600.webp", "$base/2025/09/SINGAPORE-1-600x600.webp",
  # Jumbo Cards
  "$base/2025/08/ANIMALS-600x600.jpg", "$base/2025/09/ANIMALS-1-600x600.jpg",
  "$base/2025/08/BIRDS-600x600.jpg", "$base/2025/09/Birds-1-600x600.jpg",
  "$base/2025/08/FLAGS-600x600.jpg", "$base/2025/09/flag-1-600x600.jpg",
  "$base/2025/08/FRUITS-600x600.jpg", "$base/2025/08/FRUITS-1-600x600.webp",
  "$base/2025/08/VEGETABLES-600x600.jpg", "$base/2025/08/VEGETABLES-1-600x600.webp",
  "$base/2025/08/FLOWERS-1-600x600.jpg", "$base/2025/09/FLOWERS-3-600x600.jpg",
  "$base/2025/08/CAR-LOGOS-600x600.jpg", "$base/2025/09/CAR-LOGOS-1-600x600.jpg",
  "$base/2025/08/TRANSPORT-600x600.jpg", "$base/2025/08/Transport-2-600x600.jpg",
  "$base/2025/08/MUSICAL-INSTRUMENT-1-600x600.jpg", "$base/2025/09/MUSICAL-INSTRUMENT-1-600x600.jpg",
  "$base/2025/08/OLYMPIC-GAMES-1-600x600.jpg",
  # High Contrast
  "$base/2025/10/High-Contrest-1-1-600x600.jpg", "$base/2025/10/High-Contrest-1-2-600x600.jpg",
  "$base/2025/10/High-Contrest-2-1-600x600.jpg", "$base/2025/10/High-Contrest-2-2-600x600.jpg",
  "$base/2025/10/High-Contrest-3-1-600x600.jpg", "$base/2025/10/High-Contrest-3-2-600x600.jpg",
  "$base/2025/10/High-Contrest-4-1-600x600.jpg", "$base/2025/10/High-Contrest-4-2-600x600.jpg",
  "$base/2025/10/High-Contrest-5-1-600x600.jpg", "$base/2025/10/High-Contrest-5-2-600x600.jpg",
  "$base/2025/10/High-Contrest-6-1-600x600.jpg", "$base/2025/10/High-Contrest-6-2-600x600.jpg",
  # Additional Smart Start
  "$base/2025/08/PARTS-OF-COMPUTER-600x600.jpg", "$base/2025/09/PARTS-OF-COMPUTER-1-600x600.jpg",
  "$base/2025/08/ARMY-AND-MILTARY-VOCABULARY-600x600.jpg",
  "$base/2025/09/AUSTRIA-Card-1-600x600.webp", "$base/2025/09/AUSTRIA-3-600x600.webp",
  "$base/2025/09/AZERBAIJAN-Card-1-600x600.webp", "$base/2025/09/AZERBAIJAN-1-600x600.webp",
  "$base/2025/09/BANGLADESH-Card-1-600x600.webp", "$base/2025/09/BANGLADESH-1-600x600.webp",
  "$base/2025/09/BELGIUM-Card-1-600x600.webp", "$base/2025/09/BELGIUM-1-1-600x600.webp",
  "$base/2025/09/CHILE-Card-1-600x600.webp", "$base/2025/09/CHILE-1-600x600.webp",
  "$base/2025/09/CROATIA-Card-1-600x600.webp", "$base/2025/09/CROATIA-1-600x600.webp",
  "$base/2025/09/CUBA-Card-1-600x600.webp", "$base/2025/09/CUBA-3-600x600.webp",
  "$base/2025/09/ESTONIA-Card-1-600x600.webp", "$base/2025/09/ESTONIA-1-600x600.webp",
  "$base/2025/09/FINLAND-Card-1-600x600.webp", "$base/2025/09/FINLAND-1-600x600.webp",
  "$base/2025/09/GEORGIA-Card-1-600x600.webp", "$base/2025/09/GEORGIA-1-600x600.webp",
  "$base/2025/09/GREECE-Card-1-600x600.webp", "$base/2025/09/GREECE-1-600x600.webp",
  "$base/2025/09/HONG-KONG-Card-1-600x600.webp", "$base/2025/09/HONG-KONG-1-600x600.webp"
)

$total = $urls.Count
$count = 0
foreach ($url in $urls) {
  $count++
  $filename = [System.IO.Path]::GetFileName($url)
  $filepath = Join-Path $dir $filename
  if (-not (Test-Path $filepath)) {
    Write-Progress -Activity "Downloading product images" -Status "$count/$total : $filename" -PercentComplete ($count/$total*100)
    try {
      Invoke-WebRequest -Uri $url -OutFile $filepath -ErrorAction Stop
      Write-Output "OK $count/$total : $filename"
    } catch {
      Write-Output "FAIL $count/$total : $filename - $_"
    }
  } else {
    Write-Output "SKIP $count/$total : $filename (exists)"
  }
}
Write-Output "`nDone! Downloaded $count files."
