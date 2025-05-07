import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:spacirtrasa/generated/assets.gen.dart';
import 'package:url_launcher/url_launcher.dart';

class VillagePage extends StatelessWidget {
  static const route = "/village";

  const VillagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 8),
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: Assets.images.logoVesniceRoku.image(height: 250),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OutlinedButton.icon(
              icon: const Icon(Icons.directions_bus),
              label: Text("Autobusové spoje"),
              onPressed: () => launchUrl(Uri.parse("https://www.idos.cz/")),
            ),
            OutlinedButton.icon(
              icon: const Icon(Icons.newspaper),
              label: Text("Obecní novinky"),
              onPressed: () => launchUrl(Uri.parse("https://www.orechovubrna.cz/aktuality/")),
            ),
          ],
        ),
        const MarkdownBody(data: _markdownData),
      ],
    );
  }
}

const String _markdownData = """
# Informace o obci
**Ořechov** (německy Groß Urhau) je obec v okrese Brno-venkov v Jihomoravském kraji, 11 km jihozápadně od Brna, na okraji Bobravské vrchoviny. Žije zde přibližně 2 900 obyvatel, obec v roce 2016 čítala 32 ulic.

Jedná se o vinařskou obec ve Znojemské vinařské podoblasti (viniční tratě Za Žlebama, Na Skalkách, Křiby, Záhumenice).
## Název
---

Nehledě na tvar Obucheri z falza ze 13. století hlásícího se k roku 1048 má nejstarší doložený zápis z roku 1237 podobu Ořechové a označoval místo porostlé ořeším. Od 14. století mají české doklady podobu Ořechov, která mohla vzniknout vlivem německého tvaru. Německé jméno (v nejstarších tvarech Ursichau, Ursechau) se vyvinulo z českého. V polovině 19. století se začal přidávat přívlastek Groß (česky Velký) podle jména sousedních Ořechoviček, jejichž německé jméno bylo Klein Urhau.
## Historie
---

První písemná zmínka o obci pochází z roku 1234. První pečeť pochází z roku 1740 s nápisem „Peczet obeczni Welkeho Worzechoviho“. Historie farnosti Všech svatých v Ořechově se datuje od roku 1317, kdy byl v Ořechově postaven první farní kostel v gotickém stylu.

Na konci druhé světové války proběhla v dubnu 1945 v okolí vesnice bitva u Ořechova mezi německými jednotkami a vojsky ze Sovětského svazu. Bylo to v rámci bratislavsko-brněnské operace sovětských vojsk 2. ukrajinského frontu vedených maršálem Rodionem Malinovským. Bitva probíhala od 18. dubna do 24. dubna 1945 a skončila vítězstvím rudoarmějců a ústupem Němců směrem k Brnu. Při bitvě byla obec silně poškozena. Ze 640 obytných domů bylo 176 zničeno, kvůli tomu se z Ořechova vystěhovalo 823 obyvatel do prázdných domů po vysídlených Němcích a po Židech napříč Československem.

Snahy o sloučení tří blízkých obcí se datují do období protektorátu, po válce vedly ke sloučení snahy o poválečnou obnovu sídel. Dnešní obec Ořechov vznikla 12. září 1946 sloučením tří, do té doby samostatných obcí: východně položeného Ořechova (dříve též Velkého Ořechova, německy Groß Urhau), severně položených Ořechoviček a jihozápadně položených Tikovic. Části Ořechova byly posléze značeny římskými číslicemi: Ořechov I byl původní Ořechov, Ořechov II byly Ořechovičky a Ořechov III byly Tikovice.

V roce 1946 byla schválena stavba nové školy, v roce 1947 byl položen její základní kámen. Někteří občané využili na obnovu svých sídel vládní příspěvky, započala také stavba silnice k Mělčanům.

Po komunistickém převratu v roce 1948 změnily prokomunistické akční výbory uspořádání ořechovského místního národního výboru (MNV). V pozici předsedy MNV nahradil lidovce Jaromíra Smejkala pozdější ředitel školy Bořivoj Sec. Nová škola byla otevřena dne 31. října 1949.

V Ořechově III bylo 20. června 1950 založeno jednotné zemědělské družstvo (JZD), v Ořechově I a II pak společné JZD vzniklo dne 8. srpna 1950. Většina ze zakládajících členů obou družstev nevlastnila téměř žádnou půdu, a tak byla družstevní zemědělská výroba v Ořechově menšinová. Obě JZD se v roce 1951 sloučila v jedno. K roku 1954 měl soukromý sektor 6 407 slepic a v JZD bylo 204 slepic. Tyto disproporce a tlak na socializaci vesnic z vlády vedly k tomu, že v roce 1957 přijely do Ořechova milice, které všechny zemědělce donutily ke vstupu do JZD. Kvůli potřebám nově rozrostlého JZD byla vypracována hospodářsko-technická úprava půdy, která se kvůli maximalizaci orné půdy vyznačovala spojováním menších polí ve velké hony. Kvůli této úpravě z okolí obce zmizela zvěř a obec měla problémy s půdní erozí a záplavami. Tyto problémy se snaží obec od roku 2006 minimalizovat. Byly vytvořeny biokoridory, mokřady a obnoveny některé polní stezky.

Ke sloučení všech tří katastrálních území Ořechova, Ořechoviček a Tikovic došlo v roce 1971. Místní část Ořechovičky byla zrušena již v 50. letech 20. století, na konci roku 1982 došlo ke zrušení i místní části Tikovice. Zástavba všech tří bývalých obcí je již dlouhou dobu zcela srostlá.
## Vybavenost a popis obce
---

Dopravní spojení do obce je zajištěno pěti cestami, z nichž jedna vede do Brna (Střelic), dále potom Modřic, Silůvek, Syrovic a Mělčan. Autobusovou přepravu zajišťuje linkami 501 a 510 IDS JMK na celkem sedmi zastávkách. Vzdělání zde zajišťuje mateřská, základní a základní umělecká škola, jsou zde celkem tři tělocvičny, šest hospod, zhruba 9 obchodů s potravinami, veterinář, lékárna, dva kostely a dva hřbitovy. Ořechov protíná Brněnská cyklotrasa a cyklotrasa č. 403. Severní hranici katastrálního území obce lemuje modrá turistická značka vedoucí údolím Bobravy.

Původní Ořechov se rozkládá na východě současné obce a zahrnuje ulice Kout, Kyselkova, Páralova, Pavlíkova, Příční, Sokolská, Syrovická, Ulička, a části ulic Brněnská, Ježkov, Komenského, Svadilov, Výstavní a Zahradní. V ulicích Ježkov a Svadilov je jeho zástavba srostlá se zástavbou sousedních Ořechoviček a v ulici Komenského se zástavbou sousedních Tikovic. Část hranice s Ořechovičkami prochází částí Brněnské ulice. Již zrušený katastr této části měl rozlohu 7,8973 km².

Na území původního Ořechova se nachází areál Army parku (bývalá raketová základna), areál zemědělského družstva, hřbitov, obecní úřad, pošta, 4 zastávky autobusu a orlovna. Ořechov protíná silnice II/152. Dále je zde situována mimo jiné pizzerie, cukrárna, kadeřnictví, několik obchodů s potravinami, fotbalový stadion, základní, mateřská a umělecká škola, knihovna a malé obecní muzeum. Na křižovatce ulic Sokolská, Kyselkova a Pavlíkova se nachází kostel Všech svatých. """;
