'use strict';

module.exports = function unixFormatter(results) {
    const [result] = results;
    const warnings = result.warnings.map(warning => {
        return `${result.source}:${warning.line}:${warning.column}:${warning.text}`;
    });
    return warnings.join('\n');
}
