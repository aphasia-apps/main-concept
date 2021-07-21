# broken window


bw1 <- 
  div(style = sty,
      tags$ol(start = 1,
              tags$li(tags$em(tags$sup("1"), tags$strong("The boy"),HTML('&nbsp;'), tags$sup("2"), tags$strong("was"),HTML('&nbsp;'), tags$sup("3"), tags$strong("outside."))),
              tags$ol(style = "padding-bottom:5px;",
                      tags$li("He since referent is unambiguous; some give the boy a name"),
                      tags$li("Is, decided to go"),
                      tags$li("In his front yard, on the lawn, out of the house, etc.")
              ),
              tags$p("Note: Sometimes, this concept was combined with number 2 in a statement like
         The boy was playing soccer outside or The boy was kicking the ball in the yard.
         These statements would receive full credit for both concept 1 and 2.", style = "color:black; font-size: .9em;line-height: 120%;")
      )
  )


bw2 <- 
  div(style = sty,
      tags$ol(start = 2,
              tags$li(tags$em(tags$sup("1"), tags$strong("A/The boy"),HTML('&nbsp;'), tags$sup("2"), tags$strong("was"),HTML('&nbsp;'), tags$sup("3"), tags$strong("playing soccer"))),
              tags$ol(style = "padding-bottom:5px;",
                      tags$li("See 1.1."),
                      tags$li("Played, is kicking, kicks, is practicing, etc."),
                      tags$li("With the soccer ball, with the ball, with the football* (*if not from U.S.).")),
              
              tags$p("Note: “He has a ball” or “He has a soccer ball” did not count towards this
         concept because it does not imply any kind of action with the soccer ball,
         and boy-action-ball was the concept that met criterion.", style = "color:black; font-size: .9em;line-height: 120%;")
      )
  )

bw3 <- 
  div(style = sty,
      tags$ol(start = 3,
              tags$li(tags$em(tags$sup("1"), tags$strong("The ball"),HTML('&nbsp;'), tags$sup("2"), tags$strong("breaks"),HTML('&nbsp;'), tags$sup("3"), tags$strong("the"), "man's/neighbor's", tags$strong("window."))),
              tags$ol(style = "padding-bottom:5px;",
                      tags$li("Soccer ball, football"),
                      tags$li("Goes through, went through, crashes through/into, flew through, sails through/into, shattered, is kicked through"),
                      tags$li("glass"))
      )
  )


bw4 <- 
  div(style = sty,
      tags$ol(start = 4,
              tags$li(tags$em(tags$sup("1"), tags$strong("The man"),HTML('&nbsp;'), tags$sup("2"), tags$strong("is sitting"), "in a chair and/or inside the house.")),
              tags$ol(style = "padding-bottom:5px;",
                      tags$li("His dad, his father, the father, the neighbor, the guy; some give the man a name"),
                      tags$li("Lounging, resting, relaxing, inside")),
              
              tags$p('Note: Most common were "The man is sitting", "The man is inside", "The man is sitting inside"', style = "color:black; font-size: .9em;line-height: 120%;"),
              tags$p('Note: "The man is watching TV" or something similar did not count for this concept; that was a separate relevant concept that did not meet criterion. However, if an individual said, "The man is sitting watching TV" then they would receive credit for this concept since they included "sitting."', style = "color:black; font-size: .9em;line-height: 120%;")
      )
  )


bw5 <-
  div(style = sty,
      tags$ol(start = 5,
              tags$li(tags$em(tags$sup("1"), tags$strong("The man"),HTML('&nbsp;'), tags$sup("2"), tags$strong("was startled"))),
              tags$ol(style = "padding-bottom:5px;",
                      tags$li("See 4.1"),
                      tags$li("Surprised, amazed, afraid, astonished, freaked out, stunned, shocked, angry, upset, not happy, mad")),
              
              tags$p('Note: Most common were "The man is sitting", "The man is inside", "The man is sitting inside"', style = "color:black; font-size: .9em;line-height: 120%;"),
              tags$p('Note: Occasionally, this concept was combined with number 3, in a statement such as "The ball crashed through the window and startled the man."', style = "color:black; font-size: .9em;line-height: 120%;")
      )
  )



bw6 <-
  div(style = sty,
      tags$ol(start = 6,
              tags$li(tags$em(tags$sup("1"), tags$strong("The ball"),HTML('&nbsp;'), tags$sup("2"), tags$strong("broke"),HTML('&nbsp;'), tags$sup("3"), tags$strong("a lamp"))),
              tags$ol(style = "padding-bottom:5px;",
                      tags$li("See 3.1"),
                      tags$li("Knocks down/over, smashes into, breaks, hit"),
                      tags$li("No alternative for lamp was produced"))
      )
  )


bw7 <-
  div(style = sty,
      tags$ol(start = 7,
              tags$li(tags$em(tags$sup("1"), tags$strong("The man"),HTML('&nbsp;'), tags$sup("2"), tags$strong("picked up"),HTML('&nbsp;'), tags$sup("3"), tags$strong("the ball"))),
              tags$ol(style = "padding-bottom:5px;",
                      tags$li("See 4.1"),
                      tags$li("Grabs, gets, holds/is holding, catches, captures, has"),
                      tags$li("See 3.1")),
              
              tags$p("Note: Occasionally, “The man stands up with the ball” and “The man jumps up with the ball” was used to express this concept, expressing that the man had performed some action to hold on to the ball", style = "color:black; font-size: .9em;line-height: 120%;")
      )
  )



bw8 <-
  div(style = sty,
      tags$ol(start = 8,
              tags$li(tags$em(tags$sup("1"), tags$strong("The man"),HTML('&nbsp;'), tags$sup("2"), tags$strong("looked"),HTML('&nbsp;'), tags$sup("3"), tags$strong("out of the window"))),
              tags$ol(style = "padding-bottom:5px;",
                      tags$li("See 4.1"),
                      tags$li("Looks, is looking"),
                      tags$li("Outside, out, out of the glass")),
              
              tags$p("Note: The man goes to the window, The man went to the window, or The man goes outside, etc., did not count towards this concept. These were separate relevant concepts that did not meet criterion.", style = "color:black; font-size: .9em;line-height: 120%;")
      )
  )