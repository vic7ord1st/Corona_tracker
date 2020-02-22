const cheerio = require('cheerio');
module.exports = {
    casesByRegion: (req) => {
        const $ = cheerio.load(req.data)
        let tabBody = $('#table3 > tbody > tr > td')
        let dataArray = tabBody.text().replace(/\s+/g, ' ').trim().split(' ');
        console.log(dataArray)

        let casesByCountry = [];
        let caseCount = []
        let cases = {
            country: casesByCountry,
            count: caseCount
        }
        casesByCountry.push(dataArray[0])
        caseCount.push(dataArray[1])

        let i;
        for (i = 1; i < dataArray.length; i++) {
            if (i === dataArray.length - 1) {
                return cases
            }
            switch (dataArray[i]) {
                case 'Asia':
                    if (!parseInt(dataArray[i + 2])) {
                        casesByCountry.push(`${dataArray[i + 1]} ${dataArray[i + 2]}`)
                        caseCount.push(dataArray[i + 3])
                        break;
                    }
                    else {
                        casesByCountry.push(dataArray[i + 1])
                        caseCount.push(dataArray[i + 2])
                        break;
                    }
                case 'Europe':
                    if (!parseInt(dataArray[i + 2])) {
                        casesByCountry.push(`${dataArray[i + 1]} ${dataArray[i + 2]}`)
                        caseCount.push(dataArray[i + 3])
                        break;
                    }
                    else {
                        casesByCountry.push(dataArray[i + 1])
                        caseCount.push(dataArray[i + 2])
                        break;
                    }
                case 'Oceania':
                    if (!parseInt(dataArray[i + 2])) {
                        casesByCountry.push(`${dataArray[i + 1]} ${dataArray[i + 2]}`)
                        caseCount.push(dataArray[i + 3])
                        break;
                    }
                    else {
                        casesByCountry.push(dataArray[i + 1])
                        caseCount.push(dataArray[i + 2])
                        break;
                    }
                case 'N.America':
                    if (!parseInt(dataArray[i + 2])) {
                        casesByCountry.push(`${dataArray[i + 1]} ${dataArray[i + 2]}`)
                        caseCount.push(dataArray[i + 3])
                        break;
                    }
                    else {
                        casesByCountry.push(dataArray[i + 1])
                        caseCount.push(dataArray[i + 2])
                        break;
                    }
                default:
                    break;
            }

        }

    },
    totalDeathCases: (req) => {
        let head = 'div:nth-child(2) > table > thead > tr'
        let body = 'div:nth-child(2) > table > tbody'
        return dateScraper(req, head, body)
    },
    casesByDate: (req) => {
        let head = 'div:nth-child(2) > div > table > thead > tr'
        let body = 'div:nth-child(2) > div > table > tbody'
        return dateScraper(req, head, body)
    }
}
function dateScraper(req, headSelector, bodySelector) {
    const $ = cheerio.load(req.data)
    let tabHeader = $(headSelector)
    console.log('this is it:',tabHeader.text());
    let tabBody = $(bodySelector)
    console.log('body', tabBody.text());
    let dataArray = tabHeader.text().concat(tabBody.text());
    dataArray = dataArray.replace(/\s+/g, ' ').trim().split(' ');
    let date = [];
    let totalDeaths = []
    let changeInTotalDeaths = []
    let cases = {
        date: date,
        total_deaths: totalDeaths,
        change_in_total_deaths: changeInTotalDeaths
    }
    let i;
    for (i = 10; i < dataArray.length; i++) {
        if (i === dataArray.length - 1) {
            return cases
        }
        switch (dataArray[i]) {
            case 'Feb.':
                date.push(`${dataArray[i]} ${dataArray[i + 1]}`)
                totalDeaths.push(dataArray[i + 2])
                changeInTotalDeaths.push(dataArray[i + 3])
                break;
            case 'Jan.':
                date.push(`${dataArray[i]} ${dataArray[i + 1]}`)
                totalDeaths.push(dataArray[i + 2])
                changeInTotalDeaths.push(dataArray[i + 3])
                break;
            case 'Mar.':
                date.push(`${dataArray[i]} ${dataArray[i + 1]}`)
                totalDeaths.push(dataArray[i + 2])
                changeInTotalDeaths.push(dataArray[i + 3])
                break;
        }
    }
}