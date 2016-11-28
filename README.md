# plotter
Plot the distribution of your data

Do you have a bunch of measurements that should be the same value, but are
obviously not? Have you ever wondered what are the mean and standard deviation
of your data, but can't be bothered to copy it to online tools? Do you yearn for
visuals that no simple tool out there gives you?

Well, look no further! **plotter** gives you a quick and simple way of
visualising the distribution of your data, fitting a gaussian curve on top of it
and drawing standard deviation lines for your convenience. Your exact data
points are plotted on the x axis for extra exactness.

Simply download, put your data in a file named 'data' (single number per line),
run plot.dart and plot.gnuplot in that order (Dart and gnuplot not included),
and your result will pop-up in plot.png!

There is intermediary file created: 'boxes'; and a text output file created:
'mu-sigma-max' - the mean, standard deviation, and count of the tallest
histogram bin.

![Example Plot](plot.png?raw=true "Example plot")

Enjoy!
