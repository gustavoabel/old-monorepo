const fs = require('fs');
const glob = require('glob');
const axios = require('axios');

const api = axios.create({
  baseURL: 'http://172.28.3.117:13000/api',
  headers: {
    Authorization: 'Bearer eyJrIjoiT2xQbktldTdCTnoyd1ladDdSbkpLa1pmbHNkaE9xR0siLCJuIjoiZmx5d2F5IiwiaWQiOjF9',
  },
});

const log = (file, value) => console.log(`${file} >>>`, JSON.stringify(value, undefined, 2));

const saveDashboard = async (data) => {
  try {
    const response = await api.post('/dashboards/db', data);
    return { ok: true, data: response.data };
  } catch {
    return { ok: false };
  }
};

const deleteDashboard = async (uid) => {
  try {
    const response = await api.delete(`/dashboards/uid/${uid}`);
    return { ok: true, data: response.data };
  } catch {
    return { ok: false };
  }
};

const main = async () => {
  const files = glob.sync('./grafana/*.json');

  for (const file of files) {
    let rawData = fs.readFileSync(file);

    const data = JSON.parse(rawData);

    if (data && data.dashboard) {
      await deleteDashboard(data.dashboard.uid);
    }
    const response = await saveDashboard(data);

    if (response.ok) log(file, response.data.status);
    else log(file, response.data);
  }
};

main();
