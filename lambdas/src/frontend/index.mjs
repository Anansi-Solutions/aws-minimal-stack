import path from 'path';

const dynamicRoutesPattern = /\/([A-Za-z]+)\/\d+(?=\/|$)/g;
const dynamicRoutesReplacement = '/$1/[$1Id]';

export const handler = async (evt) => {
  const request = evt.Records[0].cf.request;

  const uri = request.uri
      // ensure /route/123 is rewritten to /route/[routeId]
      .replace(dynamicRoutesPattern, dynamicRoutesReplacement);

  if (uri === '/') {
    request.uri = '/index.html';
  } else if (!path.extname(uri)) {
    request.uri = `${uri}.html`;
  }

  return request;
};
