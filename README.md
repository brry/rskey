### rstudio addin to have `str` on Keyboard shortcut F3

Rstudio addin to show the structure of a highlighted object. 
Instead of an object name, code creating data can be highlighted as well. 
It can be very useful to bind this addin to F3, for example.

```R
if(!requireNamespace("devtools")) install.packages("devtools")
devtools::install_github("brry/rstudioberry")
```

* Restart Rstudio
* On the top should be the button "Addins" which may already contain "structure of an object"
* Click on Addins - browse Addins - Keyboard shortcuts 
* map "structure of an object" to F3
