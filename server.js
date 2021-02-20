const express = require('express');
const app = express();

const port = process.env.PORT||80;
const randData = (min,max) => {
    return Math.floor(Math.random() * (max-min)+ min);
};
const randFloat = (min,max,decimalPlaces) => {
    var rand = Math.random() < 0.5 ?((1-Math.random()) * (max-min)+min) : (Math.random() * (max-min)+min);
    var power = Math.pow(10,decimalPlaces);
    return Math.floor(rand*power) / power;
}

const healthNormalData =() => ({
    bodyTemperature: randFloat(35.5,37.5,1),
    bloodPressure: randData(80,120),
    respiration: randData(12,16),
    glucose: randData(72,140),
    heartRate: randData(60,100),
    cholestrol: randData(125,200),
    oxygensaturation: randData(95,100),
});
const acuteasthmaData =() => ({
    bodyTemperature: randFloat(35.5,37.5,1),
    bloodPressure: randData(90,120),
    respiration: randData(12,16),
    glucose: randData(72,140),
    heartRate: randData(60,100),
    cholestrol: randData(125,200),
    oxygensaturation: randData(50,96),
});
const hypoxemiaData =() => ({
    bodyTemperature: randFloat(35.5,37.5,1),
    bloodPressure: randData(90,120),
    respiration: randData(12,16),
    glucose: randData(72,140),
    heartRate: randData(60,100),
    cholestrol: randData(125,200),
    oxygensaturation: ranData(50,96),
});
const chdData =() => ({
    bodyTemperature: randFloat(35.5,37.5,1),
    bloodPressure: randData(90,120),
    respiration: randData(12,16),
    glucose: randData(72,140),
    heartRate: randData(45,60),
    cholestrol: randData(200,270),
    oxygensaturation: ranData(95,100),

});
const bronchiectasisData =() => ({
    bodyTemperature: randFloat(35.5,37.5,1),
    bloodPressure: randData(90,120),
    respiration: randData(40,60),
    glucose: randData(72,140),
    heartRate: randData(60,100),
    cholestrol: randData(125,200),
   oxygensaturation: ranData(95,100),

});
const prediabetesData =() => ({
    bodyTemperature: randFloat(35.5,37.5,1),
    bloodPressure: randData(90,120),
    respiration: randData(12,16),
    glucose: randData(140,199),
    heartRate: randData(60,100),
    cholestrol: randData(125,200),
    oxygensaturation: randata(95,100),
});
const diabetesData =() => ({
    bodyTemperature: randFloat(35.5,37.5,1),
    bloodPressure: randData(90,120),
    respiration: randData(12,16),
    glucose: randData(200,350),
    heartRate: randData(60,100),
    cholestrol: randData(125,200),
    oxygensaturation: ranData(95,100),
});
app.get('/api/normal',(req,res) => {
    res.status(200).json(healthNormalData())
})
app.get('/api/acuteasthma',(req,res) => {
    res.status(200).json(acuteasthmaData())
})
app.get('/api/hypoxemia',(req,res) => {
    res.status(200).json(hypoxemiaData())
})
app.get('/api/chd',(req,res) => {
    res.status(200).json(chdData())
})
app.get('/api/bronchiectasis',(req,res) => {
    res.status(200).json(bronchiectasisData())
})
app.get('/api/prediabetes',(req,res) => {
    res.status(200).json(prediabetesData())
})
app.get('/api/diabetes',(req,res) => {
    res.status(200).json(diabetesData())
})
app.listen(port, () => console.log("server is listening to the port:",port))
