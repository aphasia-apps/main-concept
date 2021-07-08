footer_div <- p(
  column(10, offset = 1, align = "center",
         p(
           actionButton(
             inputId='source',
             label="Source Code",
             icon = icon("github"),
             onclick ="window.open('https://github.com/rbcavanaugh/mssg', '_blank')",
             style = "background:transparent; border:none;"
             
           ),
           actionButton(
             inputId = "info",
             label = "Scoring Info",
             icon = icon("info-circle"),
             style = "background:transparent; border:none;"
           ),
           actionButton(
             inputId = "about",
             label = "About Us",
             icon = icon("user-friends"),
             style = "background:transparent; border:none;"
           ),
           uiOutput("test_inputs"),
         )
  )
)