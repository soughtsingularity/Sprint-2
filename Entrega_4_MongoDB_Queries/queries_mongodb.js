db.Restaurants.find({});

db.Restaurants.find({}, {restaurant_id: 1, name:1, borough: 1, cuisine: 1});

db.Restaurants.find({}, {restaurant_id: 1, name:1, borough: 1, cuisine: 1, _id: 0});

db.Restaurants.find({}, {restaurant_id: 1, name: 1, borough: 1, "address.zipcode": 1, _id: 0});

db.Restaurants.find({borough: "Bronx"}, {name: 1});

db.Restaurants.find({borough: "Bronx"}, {name: 1}).sort({restaurant_id: 1}).limit(5);

db.Restaurants.find({borough: 'Bronx'}, {name: 1}).sort({restaurant_id: 1}).skip(5).limit(5);

db.Restaurants.find({grades: {$elemMatch:{score: {$gt: 90}}}},{name:1, "grades.score": 1, _id: 0});

db.Restaurants.find({grades: {$elemMatch: {score: { $gt: 80, $lt: 100 } }}},{name: 1,"grades.score": 1,_id: 0});

db.Restaurants.find({"address.coord.1":{$lt:-95.754168}},{name: 1,"grades.score": 1,_id: 0});

db.Restaurants.find({$expr: {$ne: [{ $trim: { input: "$cuisine" } },"American"]},"grades.score": {$gt: 70},"address.coord.0": {$lt: -65.754168}},{name: 1, cuisine:1, "grades.score": 1, _id: 0});

db.Restaurants.find({$expr:{$eq:[{$trim:{input: "$cuisine"}}, "American"]},"grades.grade": "A",borough: {$ne: "Brooklyn"}}, {name: 1, cuisine: 1, "grades.grade":1, borough: 1, _id: 0}).sort({cuisine: -1});

db.Restaurants.find({name:{$regex: /^Wil/}}, {restaurant_id:1, name:1, borough:1, cuisine:1, _id:0});

db.Restaurants.find({name:{$regex: /ces$/}}, {restaurant_id:1, name:1, borough:1, cuisine:1, _id:0});

db.Restaurants.find({name:{$regex: /Reg/, $options: "i" }}, {restaurant_id:1, name:1, borough:1, cuisine:1, _id:0});

db.Restaurants.find({$and: [{borough: "Bronx"},{$or:[{cuisine: "American"},{cuisine: "Chinese"}]}]},{name: 1, borough: 1, cuisine: 1, _id: 0});

db.Restaurants.find({borough:{$in:["Staten Island","Queens","Bronx","Brooklyn"]}},{restaurant_id: 1, name:1, borough:1, cuisine:1, _id:0 });

db.Restaurants.find({borough:{$nin:["Staten Island","Queens","Bronx","Brooklyn"]}},{restaurant_id: 1, name:1, borough:1, cuisine:1, _id:0 });

db.Restaurants.find({grades:{$elemMatch:{score:{$lt: 10}}}}, {restaurant_id: 1, name: 1, cuisine: 1});

db.Restaurants.find({$and: [{ cuisine: "Seafood" }, {$nor: [{ cuisine: { $in: ["American ", "Chinese"] } }, { name: { $regex: /^Will/, $options: "i" } }  ]}]},{restaurant_id: 1,name: 1,borough: 1,cuisine: 1,_id: 0});

db.Restaurants.find({grades: {$elemMatch: {grade: "A",score: 11,date: ISODate("2014-08-11T00:00:00Z")}}},{restaurant_id: 1, name:1, grades:1, _id:0});

db.Restaurants.find(  {"grades.1.grade": "A", "grades.1.score": 9,  "grades.1.date": ISODate("2014-08-11T00:00:00Z") },{restaurant_id: 1, name:1, grades:1, _id:0});

db.Restaurants.find({"address.coord.1": { $gt: 42, $lt: 52 } },{restaurant_id: 1,name: 1,"address.building": 1,"address.street": 1,"address.zipcode": 1,longitude: { $arrayElemAt: ["$address.coord", 0] }, latitude: { $arrayElemAt: ["$address.coord", 1] }, _id: 0});

db.Restaurants.find({},{name: 1, borough:1, _id: 0}).sort({name: 1});

db.Restaurants.find({},{name: 1, borough:1, _id: 0}).sort({name:-1});

db.Restaurants.find({},{name: 1, borough:1, cuisine:1, _id: 0}).sort({cuisine: 1, borough:-1})

db.Restaurants.find({"address.street":{$exists: true}},{name:1, "address.street":1, _id:0});

db.Restaurants.find({"address.coord":{$not: { $elemMatch: {$not:{ $type: "double" }}}}},{name:1, borough:1, "address.coord": 1});

db.Restaurants.find({"grades":{$elemMatch: {score:{$mod:[7,0]}}}},{restaurant_id:1,name:1, "grades.grade":1 });

db.Restaurants.find({name:{$regex: /mon/, $options: "i"}},{name:1, borough:1, "address.coord.0": 1, "address.coord.1":1, cuisine:1, _id: 0});

db.Restaurants.find({name: {$regex: /^Mad/}},{name: 1, borough: 1, "address.coord.0": 1, "address.coord.1": 1,cuisine:1, _id: 0});