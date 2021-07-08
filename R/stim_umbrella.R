# umbrella
u1<-
  div(style = "line-height: 160%;font-size:1.25rem;",
      tags$ol(start = 1,
              tags$li("The mother says", tags$em(tags$sup("1"), tags$strong("It's going to"),HTML('&nbsp;'), tags$sup("2"), tags$strong("rain"), HTML('&nbsp;'), "today.")),
              tags$ol(style = "padding-bottom:5px;",
                      tags$li("It’s supposed to, it might, it’s predicted, it looks like, there’s a chance"),
                      tags$li("1.2.	Sprinkle, drizzle, storm")),
              
              tags$p('Note: Occasionally produced as " (2) Rain (1) is in the forecast."', style = "color:black; font-size: .9em;line-height: 120%;"),
              tags$p('Note: Statements that implied bad weather was on the way e.g. "the weather was looking gray and cloudy outside" do not count towards this MC as it was another relevant concept that did not meet threshold.', style = "color:black; font-size: .9em;line-height: 120%;"),
              tags$p('The statement "It is raining." does not apply to this MC; see MC 5.', style = "color:black; font-size: .9em;line-height: 120%;")
      )
  )

u2<-
  div(style = "line-height: 160%;font-size:1.25rem;",
      tags$ol(start = 2,
              tags$li("The mother says", tags$em(tags$sup("1"), tags$strong("you"),HTML('&nbsp;'), tags$sup("2"), tags$strong("need to take"),HTML('&nbsp;'), tags$sup("3"), tags$strong("the umbrella"))),
              tags$ol(style = "padding-bottom:5px;",
                      tags$li("He (if appropriate referent), the boy, (male name)"),
                      tags$li("Carry, take, have, need, should have, might need, might want")),
              
              tags$p('Note: Sometimes produced as a command with the subject implied, e.g., "take this umbrella" these statements were considered AC since English allows the subject to be dropped in a command.', style = "color:black; font-size: .9em;line-height: 120%;"),
              tags$p('Note: Sometimes produced as "(1) his mother (2) offers him (3) an umbrella." or similar.', style = "color:black; font-size: .9em;line-height: 120%;"),
              tags$p('Note: Occasionally produced as a question "Don’t (1) you (2) want to take (3) this umbrella?"', style = "color:black; font-size: .9em;line-height: 120%;"),
              tags$p('Note: Sometimes produced " (2) here is (1) your (3) umbrella."', style = "color:black; font-size: .9em;line-height: 120%;")
      )
  )

u3<-
  div(style = "line-height: 160%;font-size:1.25rem;",
      tags$ol(start = 3,
              tags$li(tags$em(tags$sup("1"), tags$strong("The boy"),HTML('&nbsp;'), tags$sup("2"), tags$strong("(does something to refuse)"),HTML('&nbsp;'), tags$sup("3"), tags$strong("the umbrella"))),
              tags$ol(style = "padding-bottom:5px;",
                      tags$li("He (if appropriate referent), the boy, (male name), I (if reported speech)"),
                      tags$li("Doesn’t want, refuses, won’t/is not going to take, declines, says no, says he’ll be ok without"),
                      tags$li("It (if appropriate referent)")),
              
              tags$p('Note: Occasionally this concept was stated as "He won’t do it." in reference to the mother trying to make him take the umbrella, so the action he "won’t do" is "take the umbrella" and this should receive an AC as long as the referent is produced.', style = "color:black; font-size: .9em;line-height: 120%;")
      )
  )

u4<-
  div(style = "line-height: 160%;font-size:1.25rem;",
      tags$ol(start = 4,
              tags$li(tags$em(tags$sup("1"), tags$strong("The boy"),HTML('&nbsp;'), tags$sup("2"), tags$strong("walks"),HTML('&nbsp;'), tags$sup("3"), tags$strong("to school"))),
              tags$ol(style = "padding-bottom:5px;",
                      tags$li("See 3.1, a child"),
                      tags$li("Saves, is going to get, helps, gets, will take"),
                      tags$li("Goes, leaves, heads, takes off, starts, sets"),
                      tags$li("Outside, out of the house, out, to/for/towards [location], down the road, off, out of the door, further, forth, down, in the rain")),
              
              tags$p('Note: Sometimes the order of elements was switched, e.g. "(3) Off to school (1) he (2) goes” ', style = "color:black; font-size: .9em;line-height: 120%;")
      )
  )

u5<-
  div(style = "line-height: 160%;font-size:1.25rem;",
      tags$ol(start = 5,
              tags$li(tags$em(tags$sup("1"), tags$strong("It"),HTML('&nbsp;'), tags$sup("2"), tags$strong("is raining"))),
              tags$ol(style = "padding-bottom:5px;",
                      tags$li("The rain, the deluge"),
                      tags$li("Starts to pour, starts coming down, is falling, is sprinkling, gets harder, gets heavier, is raining, begins to rain, starts to rain, starts falling, comes, is coming down, starts raining, started sprinkling, started, rained")),
              
              tags$p('Note: Sometimes produced as a colloquialism, "The sky opens up" or "We have a downpour."', style = "color:black; font-size: .9em;line-height: 120%;"),
              tags$p('Note: Occasionally produced as "Here (2) comes (1) the rain."', style = "color:black; font-size: .9em;line-height: 120%;"),
              tags$p('Note: Do not count utterances about rain "increasing"" in severity (e.g., "It starts to rain harder.").', style = "color:black; font-size: .9em;line-height: 120%;")
      )
  )

u6<-
  div(style = "line-height: 160%;font-size:1.25rem;",
      tags$ol(start = 6,
              tags$li(tags$em(tags$sup("1"), tags$strong("The boy"),HTML('&nbsp;'), tags$sup("2"), tags$strong("gets"),HTML('&nbsp;'), tags$sup("3"), tags$strong("soaking wet"))),
              tags$ol(style = "padding-bottom:5px;",
                      tags$li("See 3.1"),
                      tags$li("Is, looks, stands there"),
                      tags$li("Soaked, drenched, dripping, very wet")),
              
              tags$p('Note: Sometimes speakers would use first person (e.g. "(1) I (2) am (3) all wet")', style = "color:black; font-size: .9em;line-height: 120%;")
      )
  )

u7<-
  div(style = "line-height: 160%;font-size:1.25rem;",
      tags$ol(start = 7,
              tags$li(tags$em(tags$sup("1"), tags$strong("The fboy"),HTML('&nbsp;'), tags$sup("2"), tags$strong("runs"),HTML('&nbsp;'), tags$sup("3"), tags$strong("back"))),
              tags$ol(style = "padding-bottom:5px;",
                      tags$li("See 3.1"),
                      tags$li("Goes, heads, returns, turns around, races, rushes, comes, gets, arrives, shows"),
                      tags$li("Home, inside")),
              
              tags$p('Note: Occasionally combined with MC 6 as in, "The boy runs back soaking wet." A person who says this should receive full credit for MCs 6 and 7.', style = "color:black; font-size: .9em;line-height: 120%;")
      )
  )

u8<-
  div(style = "line-height: 160%;font-size:1.25rem;",
      tags$ol(start = 8,
              tags$li(tags$em(tags$sup("1"), tags$strong("The mother"),HTML('&nbsp;'), tags$sup("2"), tags$strong("is"),HTML('&nbsp;'), tags$sup("3"), tags$strong("(negative emotional state"))),
              tags$ol(style = "padding-bottom:5px;",
                      tags$li("The woman, she, the lady, mom "),
                      tags$li("looks, feels"),
                      tags$li("unhappy, mad, angry, upset, annoyed, frustrated, concerned, cross, disappointed")),
              
              tags$p('Note: Sometimes reported as "his mother doesn’t look happy."', style = "color:black; font-size: .9em;line-height: 120%;"),
              tags$p('Note: Statements about physical stance/nonverbal expression do not count, e.g., "She’s scowling."', style = "color:black; font-size: .9em;line-height: 120%;"),
              tags$p('Note: Occasionally combined with MC 6 and MC 7 as in "When the boy came back home, mom was mad because he was all wet." A person who says this should receive full credit for MCs 6, 7, and 8.', style = "color:black; font-size: .9em;line-height: 120%;")
      )
  )


u9<-
  div(style = "line-height: 160%;font-size:1.25rem;",
      tags$ol(start = 9,
              tags$li(tags$em(tags$sup("1"), tags$strong("The boy"),HTML('&nbsp;'), tags$sup("2"), tags$strong("gets"),HTML('&nbsp;'), tags$sup("3"), tags$strong("an umbrella"))),
              tags$ol(style = "padding-bottom:5px;",
                      tags$li("see 3.1"),
                      tags$li("takes, receives, has, asks for, carries, retrieves, picks up, holds"),
                      tags$li("it (if appropriate referent)")),
              
              tags$p('Note: Sometimes produced as "The mother (2) gives (1) the boy (3) an umbrella.” Or “she (2) gave (3) it to (1) him.” (if appropriate referents). ', style = "color:black; font-size: .9em;line-height: 120%;")
      )
  )

u10<-
  div(style = "line-height: 160%;font-size:1.25rem;",
      tags$ol(start = 10,
              tags$li(tags$em(tags$sup("1"), tags$strong("The boy"),HTML('&nbsp;'), tags$sup("2"), tags$strong("goes back"),HTML('&nbsp;'), tags$sup("3"), tags$strong("to school"))),
              tags$ol(style = "padding-bottom:5px;",
                      tags$li("see 3.1"),
                      tags$li("walks, leaves, heads, starts, takes, is, sets forth, proceeds"),
                      tags$li("out, again, along, back, in the rain, off, on his way, with the umbrella, (leaves) the house, the school bus")),
              
              tags$p('Note: Sometimes produced as "(3) Off (1) he (2) goes again.”', style = "color:black; font-size: .9em;line-height: 120%;"),
              tags$p('Note: Occasionally combined with MC 9, as in "He goes out with the umbrella." A person who says this should receive full credit for MCs 9 and 10.', style = "color:black; font-size: .9em;line-height: 120%;")
      )
  )
