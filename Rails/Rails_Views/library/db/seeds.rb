# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Loading Books..."
Book.destroy_all 
book1 = Book.create(
    title: "In Search of Lost Time", 
    author: "Marcel Proust", 
    year: 1913, 
    category: "Novel", 
    description: "Swann's Way, the first part of A la recherche de temps perdu, Marcel Proust's seven-part cycle, was published in 1913. In it, Proust introduces the themes that run through the entire work. The narrator recalls his childhood, aided by the famous madeleine; and describes M. Swann's passion for Odette. The work is incomparable. Edmund Wilson said [Proust] has supplied for the first time in literature an equivalent in the full scale for the new theory of modern physics."
)
book2 = Book.create(
    title: "Ulysses", 
    author: "James Joyce", 
    year: 1922, 
    category: "Novel", 
    description: "Ulysses chronicles the passage of Leopold Bloom through Dublin during an ordinary day, June 16, 1904. The title parallels and alludes to Odysseus (Latinised into Ulysses), the hero of Homer's Odyssey (e.g., the correspondences between Leopold Bloom and Odysseus, Molly Bloom and Penelope, and Stephen Dedalus and Telemachus). Joyce fans worldwide now celebrate June 16 as Bloomsday."
)
book3 = Book.create(
    title: "Don Quixote", 
    author: "Miguel de Cervantes", 
    year: 1605, 
    category: "Novel", 
    description: "Alonso Quixano, a retired country gentleman in his fifties, lives in an unnamed section of La Mancha with his niece and a housekeeper. He has become obsessed with books of chivalry, and believes their every word to be true, despite the fact that many of the events in them are clearly impossible. Quixano eventually appears to other people to have lost his mind from little sleep and food and because of so much reading."
)
book4 = Book.create(
    title: "One Hundred Years of Solitude", 
    author: "Gabriel Garcia Marquez", 
    year: 1967, 
    category: "Novel", 
    description: "One of the 20th century's enduring works, One Hundred Years of Solitude is a widely beloved and acclaimed novel known throughout the world, and the ultimate achievement in a Nobel Prize–winning career. The novel tells the story of the rise and fall of the mythical town of Macondo through the history of the Buendía family. It is a rich and brilliant chronicle of life and death, and the tragicomedy of humankind. In the noble, ridiculous, beautiful, and tawdry story of the Buendía family, one sees all of humanity, just as in the history, myths, growth, and decay of Macondo, one sees all of Latin America. Love and lust, war and revolution, riches and poverty, youth and senility — the variety of life, the endlessness of death, the search for peace and truth — these universal themes dominate the novel. Whether he is describing an affair of passion or the voracity of capitalism and the corruption of government, Gabriel García Márquez always writes with the simplicity, ease, andpurity that are the mark of a master. Alternately reverential and comical, One Hundred Years of Solitude weaves the political, personal, and spiritual to bring a new consciousness to storytelling. Translated into dozens of languages, this stunning work is no less than an accounting of the history of the human race."
)
book5 = Book.create(
    title: "The Great Gatsby", 
    author: "F. Scott Fitzgerald", 
    year: 1925, 
    category: "Novel", 
    description: "The novel chronicles an era that Fitzgerald himself dubbed the 'Jazz Age'. Following the shock and chaos of World War I, American society enjoyed unprecedented levels of prosperity during the 'roaring' 1920s as the economy soared. At the same time, Prohibition, the ban on the sale and manufacture of alcohol as mandated by the Eighteenth Amendment, made millionaires out of bootleggers and led to an increase in organized crime, for example the Jewish mafia. Although Fitzgerald, like Nick Carraway in his novel, idolized the riches and glamor of the age, he was uncomfortable with the unrestrained materialism and the lack of morality that went with it, a kind of decadence."
)
book6 = Book.create(
    title: "Moby Dick", 
    author: "Herman Melville", 
    year: 1851, 
    category: "Novel", 
    description: "First published in 1851, Melville's masterpiece is, in Elizabeth Hardwick's words, 'the greatest novel in American literature.' The saga of Captain Ahab and his monomaniacal pursuit of the white whale remains a peerless adventure story but one full of mythic grandeur, poetic majesty, and symbolic power. Filtered through the consciousness of the novel's narrator, Ishmael, Moby-Dick draws us into a universe full of fascinating characters and stories, from the noble cannibal Queequeg to the natural history of whales, while reaching existential depths that excite debate and contemplation to this day."
)
book7 = Book.create(
    title: "War and Peace", 
    author: "Leo Tolstoy", 
    year: 1867, 
    category: "Narrative", 
    description: "Epic in scale, War and Peace delineates in graphic detail events leading up to Napoleon's invasion of Russia, and the impact of the Napoleonic era on Tsarist society, as seen through the eyes of five Russian aristocratic families."
)
book8 = Book.create(
    title: "Hamlet", 
    author: "William Shakespeare", 
    year: 1599, 
    category: "Tragedy", 
    description: "The Tragedy of Hamlet, Prince of Denmark, or more simply Hamlet, is a tragedy by William Shakespeare, believed to have been written between 1599 and 1601. The play, set in Denmark, recounts how Prince Hamlet exacts revenge on his uncle Claudius, who has murdered Hamlet's father, the King, and then taken the throne and married Gertrude, Hamlet's mother. The play vividly charts the course of real and feigned madness—from overwhelming grief to seething rage—and explores themes of treachery, revenge, incest, and moral corruption."
)
book9 = Book.create(
    title: "The Odyssey", 
    author: "Homer", 
    year: 1614, 
    category: "Poem", 
    description: "The Odyssey is one of two major ancient Greek epic poems attributed to Homer. It is, in part, a sequel to the Iliad, the other work traditionally ascribed to Homer. The poem is fundamental to the modern Western canon. Indeed it is the second—the Iliad being the first—extant work of Western literature. It was probably composed near the end of the eighth century BC, somewhere in Ionia, the Greek-speaking coastal region of what is now Turkey. The poem mainly centers on the Greek hero Odysseus (or Ulysses, as he was known in Roman myths) and his long journey home following the fall of Troy. It takes Odysseus ten years to reach Ithaca after the ten-year Trojan War. In his absence, it is assumed he has died, and his wife Penelope and son Telemachus must deal with a group of unruly suitors, the Mnesteres or Proci, competing for Penelope's hand in marriage."
)
book10 = Book.create(
    title: "Madame Bovary", 
    author: "Gustave Flaubert", 
    year: 1856, 
    category: "Novel", 
    description: "For daring to peer into the heart of an adulteress and enumerate its contents with profound dispassion, the author of Madame Bovary was tried for 'offenses against morality and religion.' What shocks us today about Flaubert's devastatingly realized tale of a young woman destroyed by the reckless pursuit of her romantic dreams is its pure artistry: the poise of its narrative structure, the opulence of its prose (marvelously captured in the English translation of Francis Steegmuller), and its creation of a world whose minor figures are as vital as its doomed heroine. In reading Madame Bovary, one experiences a work that remains genuinely revolutionary almost a century and a half after its creation."
)
book11 = Book.create(
    title: "The Divine Comedy", 
    author: "Dante Alighieri", 
    year: 1321, 
    category: "Poem", 
    description: "Belonging in the immortal company of the great works of literature, Dante Alighieri's poetic masterpiece, The Divine Comedy, is a moving human drama, an unforgettable visionary journey through the infinite torment of Hell, up the arduous slopes of Purgatory, and on to the glorious realm of Paradise — the sphere of universal harmony and eternal salvation."
)
book12 = Book.create(
    title: "Lolita", 
    author: "Vladimir Nabokov", 
    year: 1955, 
    category: "Novel", 
    description: "The book is internationally famous for its innovative style and infamous for its controversial subject: the protagonist and unreliable narrator, middle aged Humbert Humbert, becomes obsessed and sexually involved with a twelve-year-old girl named Dolores Haze."
)