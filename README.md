### rstudio addins for Keyboard shortcuts

Rstudio addins to show the structure or head of a highlighted object or open it in a viewing window. 
Instead of an object name, code creating data can be highlighted as well. 

It can be very useful to bind the addins like this:

* F3 - structure of an object - `str(selected_code)`
* F4 - head of an object - `head(selected_code)`
* F6 - View an object - `View(selected_code)`

To use these keyboard shortcuts, install this package and follow the instructions below.

```R
if(!requireNamespace("devtools")) install.packages("devtools")
devtools::install_github("brry/rstudioberry")
```

* Restart Rstudio
* On the top should be the button "Addins" which may already contain "structure of an object"
* Click on Addins - browse Addins - Keyboard shortcuts 
* map "structure of an object" to F3 
* map the others, as outlined above
