import resolve from "resolve";
import path from "path";
import child_process from "child_process";

export default class NCMake {

    constructor(){
        console.log(NCMake.getNANLocation());

    }
    build(){
      // var spwaned = child_process.spawn('cmake', [argv].concat(process.argv), {
      //     stdio: [process.stdin, null, null]
      // });
      //
      // spwaned.stdout.on('data', (data) => {
      //     console.log(`stdout: ${data}`);
      // });
      //
      // spwaned.stderr.on('data', (data) => {
      //     console.log(`stderr: ${data}`);
      // });
      //
      // spwaned.on('close', (code) => {
      //     console.log(`child process exited with code ${code}`);
      // });
    }
    static getNANLocation(){
        return require(resolve.sync('nan', { basedir: path.join([__dirname, '..'])}));
    }
}
