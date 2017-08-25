import NCMake from "./ncmake";
import yargs from "yargs";

export const cli = (location) => {
    const argv = yargs
    .usage('$0 <cmd> [args]')
    .command('test [name]', 'welcome ter yargs!', {
        name: {
            default: 'default name',
            describe: 'the name to say hello to'
        }
    })
    .command('build', 'welcome ter yargs!', {
        name: {
            default: 'default name',
            describe: 'the name to say hello to'
        }
    })
    .help().argv;

    const ncmake = new NCMake({location});

    // ncmake
    ncmake.build();
}
