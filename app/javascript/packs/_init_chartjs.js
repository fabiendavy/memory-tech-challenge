import Chart from 'chart.js';

const chart = () => {

  const dataX = document.getElementById('monthly-data-x').dataset;
  const dataY = document.getElementById('monthly-data-y').dataset;

  var ctx = document.getElementById('myChart').getContext('2d');
  var myChart = new Chart(ctx, {
    type: 'bar',
    data: {
      labels: [dataX.january, dataX.february, dataX.march, dataX.april, dataX.may, dataX.june, dataX.july, dataX.august, dataX.september, dataX.october, dataX.november, dataX.december],
      datasets: [{
        label: 'Monthly revenue',
        data: [dataY.january, dataY.february, dataY.march, dataY.april, dataY.may, dataY.june, dataY.july, dataY.august, dataY.september, dataY.october, dataY.november, dataY.december],
        backgroundColor: [
          'rgba(255, 99, 132, 0.2)',
          'rgba(255, 99, 132, 0.2)',
          'rgba(255, 99, 132, 0.2)',
          'rgba(255, 99, 132, 0.2)',
          'rgba(255, 99, 132, 0.2)',
          'rgba(255, 99, 132, 0.2)',
          'rgba(255, 99, 132, 0.2)',
          'rgba(255, 99, 132, 0.2)',
          'rgba(255, 99, 132, 0.2)',
          'rgba(255, 99, 132, 0.2)',
          'rgba(255, 99, 132, 0.2)',
          'rgba(255, 99, 132, 0.2)'
        ],
        borderColor: [
          'rgba(255, 99, 132, 0.2)',
          'rgba(255, 99, 132, 0.2)',
          'rgba(255, 99, 132, 0.2)',
          'rgba(255, 99, 132, 0.2)',
          'rgba(255, 99, 132, 0.2)',
          'rgba(255, 99, 132, 0.2)',
          'rgba(255, 99, 132, 0.2)',
          'rgba(255, 99, 132, 0.2)',
          'rgba(255, 99, 132, 0.2)',
          'rgba(255, 99, 132, 0.2)',
          'rgba(255, 99, 132, 0.2)',
          'rgba(255, 99, 132, 0.2)'
        ],
        borderWidth: 1
      }]
    },
    options: {
      scales: {
        yAxes: [{
          ticks: {
            beginAtZero: true
          }
        }]
      }
    }
  });
};

export {
  chart
};
