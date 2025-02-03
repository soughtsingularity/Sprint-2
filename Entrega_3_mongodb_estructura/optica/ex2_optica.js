db.createCollection("glasses", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["brand", "graduation", "glass_color", "frame_type", "frame_color", "provider", "price"],
        properties: {
          brand: { bsonType: "string" },
          graduation: {
            bsonType: "object",
            required: ["left", "right"],
            properties: {
              left: { bsonType: "double" },
              right: { bsonType: "double" }
            }
          },
          glass_color: {
            bsonType: "object",
            required: ["left", "right"],
            properties: {
              left: { bsonType: "string" },
              right: { bsonType: "string" }
            }
          },
          frame_type: { bsonType: "string" },
          frame_color:{bsonType: "string"},
          provider:{bsonType: "objectId"},
          price: { bsonType: "double" },
          sales: {
          bsonType: "array",
          items: {
            bsonType: "object",
            required: ["client_id", "employee_id", "purchase_date"],
            properties: {
              client_id: { bsonType: "objectId" },
              employee_id: { bsonType: "objectId" },
              purchase_date: { bsonType: "date" }
            }
          }
        }
      }
    }
  },
  validationLevel: "strict",
  validationAction: "error"
});


db.createCollection("providers",{
  validator:{
    $jsonSchema:"object",
    $bsonType:"object",
    required:["name", "address", "telephone", "fax", "nif"],
    properties:{
      name:{bsonType: "string"},
      address:{bsonType: "object",
        items:{
          bsonType: "object",
          required:["street", "number", "floor", "door", "city", "postal_code", "country"],
          properties:{
            street: {bsonType: "string"},
            number: {bsonType: "int"},
            floor: {bsonType: "string"},
            door:{bsonType: "string"},
            city:{bsonType: "string"},
            postal_code:{bsonType: "int"},
            country:{bsonType: "string"}
          }
        }
      },
      telephone:{bsonType:"string"},
      fax:{bsonType:"string"},
      nif:{bsonType:"string"}
    }
  },
  validationLevel: "strict",
  validationAction: "error"
});

db.createCollection("clients", {
  validator:{
      $jsonSchema: {
          bsonType:"object",
          required:["name", "address", "telephone", "email", "register_date", "new_client"],
          properties:{
              name: {bsonType:"string"},
              address: {
                  bsonType: "object",
                  required:["street", "number", "city", "postal_code"],
                  properties:{
                      street: {bsonType: "string"},
                      number: {bsonType: "int"},
                      city:{bsonType: "string"},
                      postal_code: {bsonType: "int"}
                  }
              },
              telephone:{bsonType: "string"},
              email:{bsonType: "string"},
              register_date:{bsonType: "date"},
              new_client:{bsonType: "bool"},
              refered_by:{bsonType: "objectId"},
          }
      }
  },
  validationLevel: "strict",
  validationAction: "error"
});

db.createCollection("employees", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["name"],
      properties: {
        name: { bsonType: "string" }
      }
    }
  },
  validationLevel: "strict",
  validationAction: "error"
});