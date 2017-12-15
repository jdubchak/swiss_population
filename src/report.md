2016 Swiss Non Permanent and Permanent Residents Born In Canada
================

Introduction
------------

Switzerland is consistently ranked among the top countries having the highest quality of life due to its economic offerings, public transportation, health care, and landscape[1][2]. Switzerland is also noted for the quality of life and employment opportunities offered to foreigners[3][4]. Out of personal curiosity, I was interested to find out how many non permanent and permanent residents were born in Canada, and where they reside. The goal is to determine whether the larger city centres, including Basel, Bern, Geneva, Lausanne, and Zurich, were home to Canadians living abroad.

Methods
-------

All data was manually collected from a Swiss government website, [STAT-TAB](https://www.pxweb.bfs.admin.ch/pxweb/en/px-x-0102010000_104/-/px-x-0102010000_104.px), for the year 2016, and can be found in the [raw data folder](https://github.com/jdubchak/swiss_population/tree/master/swiss_population/data/raw_data). The data was cleaned in Python, using `pandas` (v0.20.1), and figures were generated in R, using `tidyverse` (v1.1.1), `ggplot2` (v2.2.1) and `ggswissmaps`(v0.1.1). All figures were generated using the `shp[["g1k15"]]` dataframe from `ggswissmaps`, and cantons were mapped from the data to this dataframe. Two statistics were generated, the proportion, represented as percentages, of all non permanent and permanent residents who are Canadian by canton $\\frac{Canadian np/p}{all np/p}$, and the proportion, also represented as percentages, of Canadian non permanent and permanent residents by canton $\\frac{Canadians in Canton}{All Canadians}$. Extra figures without annotations are included in the appendix.

Results
-------

### Non Permanent and Permanent Residents who are Canadian

#### Non Permanent Residents

Table 1: Extreme Values of Proportion (%) of all Non Permanent Swiss Residents Born in Canada, 2016

| Canton                           |  Percentage|
|:---------------------------------|-----------:|
| Neuchatel                        |        4.99|
| Jura                             |        1.92|
| Geneve                           |        1.57|
| Schwyz                           |        0.17|
| Graubunden / Grigioni / Grischun |        0.05|
| Appenzell Ausserrhoden           |        0.00|
| Appenzell Innerrhoden            |        0.00|
| Obwalden                         |        0.00|
| Uri                              |        0.00|

![Proportion of All Non Permanent Swiss Residents Born in Canada by Canton, 2016](../results/nonperm_Canadian_percentages_by_canton_annotated.png)

Table 1 and Figure 1 show the largest proportion of all Canadians who are non permanent residents in Switzerland reside in the canton of Neuchatel, followed by Jura and Geneve. In contrast, no Canadian non permanent Swiss residents reside in Appenzell Ausserrhoden, Appenzell Innerrhoden, Obwalden, or Uri.

#### Permanent Residents

Table 2: Extreme Values of Proportion (%) of all Permanent Swiss Residents Born in Canada, 2016

| Canton                 |  Percentage|
|:-----------------------|-----------:|
| Vaud                   |        0.56|
| Geneve                 |        0.55|
| Zug                    |        0.39|
| Jura                   |        0.38|
| Thurgau                |        0.04|
| Glarus                 |        0.04|
| Uri                    |        0.04|
| Appenzell Ausserrhoden |        0.04|
| Schaffhausen           |        0.04|

![Proportion of all Permanent Swiss Residents Born in Canada by Canton, 2016](../results/perm_Canadian_percentages_by_canton_annotated.png)

Table 2 and Figure 2 show the largest proportion of all Canadians who are permanent residents in Switzerland reside in the cantons of Vaud and Geneve. In contrast, the smallest proportion Reside in Glarus, Uri, Appenzell Ausserrhoden and Schaffhausen.

### Canadian Non Permanent and Permanent Residents by Canton

#### Non Permanent Residents

Table 3: Extreme Values of Proportion (%) of Canadian Non Permanent Swiss Residents, 2016

| Canton                 |  Percentage|
|:-----------------------|-----------:|
| Vaud                   |       22.65|
| Zurich                 |       21.22|
| Neuchatel              |       12.45|
| Geneve                 |       11.43|
| Glarus                 |        0.20|
| Appenzell Ausserrhoden |        0.00|
| Appenzell Innerrhoden  |        0.00|
| Obwalden               |        0.00|
| Uri                    |        0.00|

![Proportion of Canadians Non Permanent Residents by Canton, 2016](../results/nonperm_all_Canadians_by_canton_annotated.png)

Table 3 and Figure 3 show the largest proportion of all Canadians residing in Switzerland, who are non permanent residents, reside in the cantons of Vaud, Zurich, Neuchatel, and Geneve. In contrast, no Canadian non permanent Swiss residents reside in Appenzell Ausserrhoden, Appenzell Innerrhoden, Obwalden, or Uri.

#### Permanent Residents

Table 4: Extreme Values of Proportion (%) of Canadian Permanent Swiss Residents, 2016

| Canton                 |  Percentage|
|:-----------------------|-----------:|
| Vaud                   |       28.56|
| Geneve                 |       21.72|
| Zurich                 |       15.48|
| Appenzell Ausserrhoden |        0.06|
| Glarus                 |        0.06|
| Obwalden               |        0.06|
| Appenzell Innerrhoden  |        0.05|
| Uri                    |        0.03|

![Proportion of Canadian Permanent Residents by Canton, 2016](../results/perm_all_canadians_by_canton_annotated.png)

Table 4 and Figure 4 show the largest proportion of all Canadians residing in Switzerland, who are permanent residents, reside in the cantons of Vaud, Zurich, and Geneve. In contrast, the smallest proportion of Canadian permanent Swiss residents reside in Appenzell Innerrhoden, and Uri.

Table 5: All Representations of Canadians living in Switzerland by Canton

| Cantons                          |  Percentage of all Non Permanent Residents Born in Canada|  Percentage of all Permanent Residents Born in Canada|  Percentage of Canadian Non Permanent Residents Per Canton|  Percentage of Canadian Permanent Residents Per Canton|
|:---------------------------------|---------------------------------------------------------:|-----------------------------------------------------:|----------------------------------------------------------:|------------------------------------------------------:|
| Vaud                             |                                                      1.20|                                                  0.56|                                                      22.65|                                                  28.56|
| Zurich                           |                                                      0.82|                                                  0.19|                                                      21.22|                                                  15.48|
| Neuchatel                        |                                                      4.99|                                                  0.22|                                                      12.45|                                                   1.98|
| Geneve                           |                                                      1.57|                                                  0.55|                                                      11.43|                                                  21.72|
| Bern / Berne                     |                                                      0.37|                                                  0.15|                                                       4.69|                                                   4.81|
| Valais / Wallis                  |                                                      0.29|                                                  0.21|                                                       4.29|                                                   3.05|
| Aargau                           |                                                      0.35|                                                  0.09|                                                       3.47|                                                   2.70|
| Ticino                           |                                                      0.66|                                                  0.06|                                                       3.27|                                                   1.28|
| Fribourg / Freiburg              |                                                      0.87|                                                  0.25|                                                       3.06|                                                   3.14|
| Basel-Stadt                      |                                                      0.52|                                                  0.37|                                                       3.06|                                                   4.79|
| Solothurn                        |                                                      0.50|                                                  0.07|                                                       1.84|                                                   0.71|
| Zug                              |                                                      0.36|                                                  0.39|                                                       1.22|                                                   2.44|
| St. Gallen                       |                                                      0.21|                                                  0.06|                                                       1.22|                                                   1.23|
| Luzern                           |                                                      0.21|                                                  0.12|                                                       1.22|                                                   1.62|
| Jura                             |                                                      1.92|                                                  0.38|                                                       1.02|                                                   0.84|
| Thurgau                          |                                                      0.27|                                                  0.04|                                                       1.02|                                                   0.49|
| Graubunden / Grigioni / Grischun |                                                      0.05|                                                  0.05|                                                       0.82|                                                   0.39|
| Basel-Landschaft                 |                                                      0.22|                                                  0.24|                                                       0.61|                                                   2.94|
| Nidwalden                        |                                                      0.71|                                                  0.15|                                                       0.41|                                                   0.18|
| Schaffhausen                     |                                                      0.24|                                                  0.04|                                                       0.41|                                                   0.15|
| Schwyz                           |                                                      0.17|                                                  0.22|                                                       0.41|                                                   1.20|
| Glarus                           |                                                      0.28|                                                  0.04|                                                       0.20|                                                   0.06|
| Appenzell Ausserrhoden           |                                                      0.00|                                                  0.04|                                                       0.00|                                                   0.06|
| Appenzell Innerrhoden            |                                                      0.00|                                                  0.15|                                                       0.00|                                                   0.05|
| Obwalden                         |                                                      0.00|                                                  0.06|                                                       0.00|                                                   0.06|
| Uri                              |                                                      0.00|                                                  0.04|                                                       0.00|                                                   0.03|

Table 5 shows the largest proportion of Swiss permanent and non permanent residents born in Canada reside in Vaud, Zurich, Neuchatel, and Geneve.

Conclusion
----------

Zurich, with its dominating finance sector[5], Geneva and Basel, with their large pharmaceutical industries[6][7], Lausanne with Nespresso[8] and the capital city of Bern with its tourism, agriculture and wine industries[9] were expected to be home to the majority (defined as &gt;50%) of Canadian expatriates. Zurich, Bern, and Geneva are located in cantons of the same name, while Lausanne is a city in Vaud, and Basel is a city in Basel-Stadt. This expectation was met as 63.05% of Canadian non permanent residents in 2016 resided in these cantons, as seen in Table 5, column 3, *Percentage of Canadian Non Permanent Residents Per Canton*. Also shown in Table 5, column 4 *Percentage of Canadian Permanent Residents Per Canton*, 73.6% of all Canadian permanent residents resided in these 5 cantons. For curiosities sake, of the proportion of all expatriate non permanent residents of Switzerland, 4.48% were born in Canada. Additionally, of all expatriate permanent residents in Switzerland, 1.82% were born in Canada. Surprisingly, the largest proportion of all non permanent swiss residents born in Canada by canton in 2016, resided in Neuchatel, as show in Figure 1. This could be the result of its high-tech and research industries[10]. Therefore, overall, most Swiss non permanent and permanent residents who were born in Canada reside in one of the five cantons containing the largest cities and largest industries. However, in order to directly conclude this is a result of industry would require further analysis.

Appendix
--------

Figures below are the same as those in the Results section, however annotations are excluded.

![Proportion of All Non Permanent Swiss Residents Born in Canada by Canton, 2016](../results/nonperm_Canadian_percentages_by_canton_w5large_text.png)

![Proportion of all Permanent Swiss Residents Born in Canada by Canton, 2016](../results/perm_Canadian_percentages_by_canton_w5large_text.png)

![Proportion of all Permanent Swiss Residents Born in Canada by Canton, 2016](../results/perm_Canadian_percentages_by_canton_w5large_text.png)

![Proportion of Canadian Permanent Residents by Canton, 2016](../results/perm_all_canadians_by_canton_w5large_text.png)

[1] [Business Insider](http://uk.businessinsider.com/mercer-2017-quality-of-living-worldwide-city-rankings-2017-3)

[2] [Numbeo](https://www.numbeo.com/quality-of-life/rankings_by_country.jsp)

[3] [The Local](https://www.thelocal.ch/20170314/survey-swiss-cities-offer-world-beating-quality-of-life)

[4] [Swiss Info](https://www.swissinfo.ch/eng/expat-ranking_swiss-cities-among-world-s-best-for-quality-of-life/43027156)

[5] [Zurich City](https://www.stadt-zuerich.ch/portal/en/index/portraet_der_stadt_zuerich/wirtschaftsraum_u_-foerderung.html)

[6] [Swiss Community](https://www.swisscommunity.org/en/explore-switzerland/geneva/economy)

[7] [Basel Industry](https://www.basel.com/en/Good-to-know/Commerce-and-industry)

[8] [Lausanne Wikipedia](https://en.wikipedia.org/wiki/Lausanne)

[9] [Swiss Community](https://www.swisscommunity.org/en/explore-switzerland/berne/economy)

[10] [Neuchatel Economy](https://en.wikipedia.org/wiki/Neuch%C3%A2tel#Economy)
