# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Post.create(title:             "Test Post",
            short_description: "Test short description")

et = EventType.create(name:     "Demo form",
                      schema:   '{"type":"object","title":"","properties":{"email":{"title":"E-mail","type":"string","format":"email"},"name":{"title":"Becenév","type":"string","default":"John Doe"},"id":{"title":"Személyi igazolvány szám","type":"string"},"glasses":{"enum":["igen","nem"],"title":"Szemüveges vagyok","type":"string"},"other":{"title":"Megjegyzés","type":"string"},"eula":{"title":"A szabályzatot elfogadom","type":"boolean"}},"dependencies":{},"required":["email","name","id","glasses","eula"]}',
                      uischema: '{"glasses":{"ui:widget":"radio"},"other":{"ui:widget":"textarea"},"ui:order":["email","name","id","glasses","other","eula"]}')

et_short = EventType.create(name:     "Short form",
                            schema:   '{"type":"object","properties":{"yes":{"enum":["nem"],"title":"Igen?","type":"string"}},"dependencies":{},"required":["yes"],"title":"","description":""}',
                            uischema: '{"yes":{"ui:widget":"radio"},"ui:order":["yes"]}')

Event.create(name: "Test event", event_type: et)