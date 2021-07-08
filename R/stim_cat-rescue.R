# cat rescue
cr1 <-
  div(style = "line-height: 160%;font-size:1.25rem;",
      tags$ol(start = 1,
              tags$li(tags$em(tags$sup("1"), tags$strong("The little girl"),HTML('&nbsp;'), tags$sup("2"), tags$strong("was riding"),HTML('&nbsp;'), tags$sup("3"), tags$strong("her bicycle"))),
              tags$ol(style = "padding-bottom:5px;",
                      tags$li("She (if appropriate referent), the girl, the child, any girl’s name"),
                      tags$li("Rode, rides, was on, is playing on, stopped riding, got off, was beside, has"),
                      tags$li("Bike, tricycle, trike, it (if appropriate referent)"))
      )
  )


cr2<-
  div(style = "line-height: 160%;font-size:1.25rem;",
      tags$ol(start = 2,
              tags$li(tags$em(tags$sup("1"), tags$strong("The cat"),HTML('&nbsp;'), tags$sup("2"), tags$strong("was in"),HTML('&nbsp;'), tags$sup("3"), tags$strong("the tree"), "because the dog chased it.")),
              tags$ol(style = "padding-bottom:5px;",
                      tags$li("Kitty, kitten, it (if appropriate referent), any cat name"),
                      tags$li("Was up, was stuck in, got stuck in, climbed up, ran up, goes up, gets in, was caught in, ends up in, was on, was chased up, was scared up"),
                      tags$li("The tree limb, limb")),
              
              tags$p('Note: Sometimes expressed as "The dog (2) chased (1) the cat (3) up the tree." or "The girl (2) saw (1) the cat (3) in the tree."', style = "color:black; font-size: .9em;line-height: 120%;")
      )
  )




cr3<-
  div(style = "line-height: 160%;font-size:1.25rem;",
      tags$ol(start = 3,
              tags$li(tags$em(tags$sup("1"), tags$strong("The dog"),HTML('&nbsp;'), tags$sup("2"), tags$strong("was barking"),HTML('&nbsp;'), tags$sup("3"), "up the tree")),
              tags$ol(style = "padding-bottom:5px;",
                      tags$li("It (if appropriate referent), puppy, pup, any dog name"),
                      tags$li("Barks, is barking, barked, is yelping")),
              
              tags$p('Note: "The dog chased the cat" should not apply to this statement as it was a separate relevant concept that did not meet threshold but was occasionally combined with additional elements that could apply to MC2', style = "color:black; font-size: .9em;line-height: 120%;")
      )
  )



cr4<-
  div(style = "line-height: 160%;font-size:1.25rem;",
      tags$ol(start = 4,
              tags$li(tags$em(tags$sup("1"), tags$strong("The man"),HTML('&nbsp;'), tags$sup("2"), tags$strong("climbed up"),HTML('&nbsp;'), tags$sup("3"), tags$strong("the tree"))),
              tags$ol(style = "padding-bottom:5px;",
                      tags$li("The neighbor, the father, dad, daddy, someone older, big brother, he (if appropriate referent), any man’s name"),
                      tags$li("Was climbing, climbed, climbs, ran up, goes up into, got up on, crawls in/on"),
                      tags$li("The branch, the limb, the ladder, it (if appropriate referent), there"))
      )
  )



cr5<-
  div(style = "line-height: 160%;font-size:1.25rem;",
      tags$ol(start = 5,
              tags$li(tags$em(tags$sup("1"), tags$strong("The man"),HTML('&nbsp;'), tags$sup("2"), tags$strong("tries to rescue"),HTML('&nbsp;'), tags$sup("3"), tags$strong("the cat"))),
              tags$ol(style = "padding-bottom:5px;",
                      tags$li("See 4.1"),
                      tags$li("Wants to help, wants to rescue, tries to get, attempts to get, tries to reach, goes to get, tries to retrieve, went up after, comes to rescue"),
                      tags$li("See 2.1")),
              
              tags$p('Note: Frequently combined with MC 4 as in "The man climbed up the tree to get the cat."; a person who says this should receive full credit for MCs 4 and 5.', style = "color:black; font-size: .9em;line-height: 120%;"),
              tags$p('Note: Occasionally combined with MC 7 as in "He’s stuck in the tree trying to get the cat."; a person who says this should receive full credit for MCs 5 and 7.', style = "color:black; font-size: .9em;line-height: 120%;")
      )
  )


cr6<-
  div(style = "line-height: 160%;font-size:1.25rem;",
      tags$ol(start = 6,
              tags$li(tags$em(tags$sup("1"), tags$strong("The ladder"),HTML('&nbsp;'), tags$sup("2"), tags$strong("fell down"),HTML('&nbsp;'))),
              tags$ol(style = "padding-bottom:5px;",
                      tags$li("It (if appropriate referent)"),
                      tags$li("Is down, falls, fell, has fallen, has fallen down, got away from him, is on the ground, has slipped away, has dropped away, fell off, has been knocked down")),
              
              tags$p('Note: Sometimes expressed with an agent that caused the ladder to fall, such as the wind or dog (e.g., "the dog knocked the ladder down").', style = "color:black; font-size: .9em;line-height: 120%;")
      )
  )



cr7<-
  div(style = "line-height: 160%;font-size:1.25rem;",
      tags$ol(start = 7,
              tags$li(tags$em(tags$sup("1"), tags$strong("The father"),HTML('&nbsp;'), tags$sup("2"), tags$strong("is stuck"),HTML('&nbsp;'), tags$sup("3"), tags$strong("in the tree"), "with the cat.")),
              tags$ol(style = "padding-bottom:5px;",
                      tags$li("See 4.1, the man and the cat, they (if appropriate referents)"),
                      tags$li("Is up, is, is stranded, is caught, ended up, is marooned, is sitting"),
                      tags$li("On the branch, on the limb, up there")),
              
              tags$p('Note: Sometimes expressed as: "(1) The man (2) couldn’t (3) get down."', style = "color:black; font-size: .9em;line-height: 120%;")
      )
  )

cr8<-
  div(style = "line-height: 160%;font-size:1.25rem;",
      tags$ol(start = 8,
              tags$li(tags$em(tags$sup("1"), tags$strong("Someone"),HTML('&nbsp;'), tags$sup("2"), tags$strong("called"),HTML('&nbsp;'), tags$sup("3"), tags$strong("the fire department"))),
              tags$ol(style = "padding-bottom:5px;",
                      tags$li("The mother, the neighbor, the lady next door, the girl, the father, a passerby, an onlooker, he/she/they"),
                      tags$li("Notifies, alerts, got"),
                      tags$li("The firemen, 911")),
              
              tags$p('Note: Sometimes expressed as a passive such as: " (3) The fire department (2) has been called."', style = "color:black; font-size: .9em;line-height: 120%;"),
              tags$p('Note: For this concept, a pronoun without a preceding referent is scored as AC since this action is not depicted in the picture stimuli.', style = "color:black; font-size: .9em;line-height: 120%;")
      )
  )


cr9<-
  div(style = "line-height: 160%;font-size:1.25rem;",
      tags$ol(start = 9,
              tags$li(tags$em(tags$sup("1"), tags$strong("The fire department"),HTML('&nbsp;'), tags$sup("2"), tags$strong("comes"),HTML('&nbsp;'), tags$sup("3"), tags$strong("with a ladder"))),
              tags$ol(style = "padding-bottom:5px;",
                      tags$li("The firefighters, the firemen, the fire truck, they (if appropriate referent or if includes ladder or other context so that the referent is not ambiguous)"),
                      tags$li("Is on the way, is/are coming, came, have arrived, rushes out, brings")),
              
              tags$p('Note: Sometimes combined with MC 8 as in "The mother called the fire department to come with their ladder." A person who says this should receive full credit for MCs 8 and 9.', style = "color:black; font-size: .9em;line-height: 120%;"),
              tags$p('Note: While the first two essential elements met 66% threshold, the final element “with a ladder” was only produced by 33% of the sample.', style = "color:black; font-size: .9em;line-height: 120%;")
      )
  )



cr10<-
  div(style = "line-height: 160%;font-size:1.25rem;",
      tags$ol(start = 10,
              tags$li(tags$em(tags$sup("1"), tags$strong("The fire department"),HTML('&nbsp;'), tags$sup("2"), tags$strong("rescues"),HTML('&nbsp;'), tags$sup("3"), tags$strong("them"))),
              tags$ol(style = "padding-bottom:5px;",
                      tags$li("See 9.1 (but not fire truck)"),
                      tags$li("Saves, is going to get, helps, gets, will take"),
                      tags$li("The man, the cat, the man and the cat")),
              
              tags$p('Note: Often combined with MC 9 as in "The fire department comes with a ladder to rescue them." A person who says this should receive full credit for MCs 9 and 10.', style = "color:black; font-size: .9em;line-height: 120%;"),
              tags$p('Note: Sometimes combined with MC 8 and MC 9 as in "The mother called the fire department to come and rescue the father with a ladder." A person who says this should receive full credit for MCs 8, 9, and 10.', style = "color:black; font-size: .9em;line-height: 120%;")
      )
  )