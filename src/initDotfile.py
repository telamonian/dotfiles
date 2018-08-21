#!/usr/bin/env python
from argparse import ArgumentParser, SUPPRESS
import os,sys

from bannerMaker import BannerMaker

#### helper class for parsing command line args
class ArgumentParserInitDotfile(ArgumentParser):
    # def error(self, message):
    #     """error(message: string)
    #     An override of the default error handler that includes some more helpful/specific messages
    #     """
    #     self.print_help(sys.stderr)
    #
    #     if message.count('the following arguments are required: sfilePath'):
    #         message += '\nBe careful not to put the path to the sfile after the -i flag, as it may get confused for a search pattern in this case'
    #
    #     args = {'prog': self.prog, 'message': message}
    #     self.exit(2, gettext('%(prog)s: error: %(message)s\n') % args)

    # def parse_known_args(self, args=None, namespace=None):
    #     """We override this method since it is also called by .parse_args()
    #     """
    #     namespace,args = super(ArgumentParserInitDotfile, self).parse_known_args(args=args, namespace=namespace)
    #
    #     # resolve the path during parsing
    #     namespace.path = os.path.join(dotfilesPath, namespace.name)
    #
    #     return namespace,args

    def parse_kwargs(self):
        return vars(self.parse_args())

#### Main class
class Main(object):
    # default modeline. Ensures that vim highlight's a file as bash in the absence of other hints. Requires some customization of a user's ~/.vim directory in order to work
    modelineDefault = '# vim: ft=bash\n'

    # the real path to this script. Thus for now this script should remain at the toplevel of the dotfile repo
    thisPath = os.path.dirname(os.path.realpath(__file__))

    # path to dir this script is run in
    dotfilePth = os.getcwd()

    def initParser(self):
        parser = ArgumentParserInitDotfile(description='This script creates a new dotfile, including a filetype=bash modeline for vim and an optional banner.')

        parser.add_argument('name',                          help='The new dotfile will be created at %s.' % os.path.join(self.dotfilePth, '<name>'))
        parser.add_argument('-b', '--banner',                help='[optional] A string that will be converted to ascii art and used as a header in the new dotfile.')
        parser.add_argument('-m', '--modeline',
                            default=self.modelineDefault,    help="""[default = "%s"] Modeline that tells vim how to highlight the new dotfile's text.""" % self.modelineDefault)
        parser.add_argument('-f', '--force',
                            action='store_true',             help='If this flag is set, this script will overwrite any existing dotfile at %s.' % os.path.join(self.dotfilePth, '<name>'))
        return parser

    def main(self):
        """ - Initializes a dotfile, including a filetype=bash modeline for vim and an optional banner.
            - The name of the dotfile is the first argument passed, and the path is automatically determined from the location of this script.
            - A fancy ascii art banner can be added to the top of the new dotfile by passing the desired text as an (optional) second argument
        """
        # parse the cmd line
        parser = self.initParser()
        kwargs = parser.parse_kwargs()

        # resolve the path to the new dotfile
        initPath = os.path.join(self.dotfilePth, kwargs['name'])

        # don't allow overwriting of existing dotfile without `--force` flag
        if (os.path.isfile(initPath) or os.path.isdir(initPath)) and not kwargs['force']:
            raise ValueError("dotfile at: %s already exists!" % initPath)

        # open up the new dotfile for writing
        with open(initPath, 'w') as dotfile:
            # add the modeline
            dotfile.write(kwargs['modeline'])
            # add a newline
            dotfile.write('\n')

            # make a banner at the top of the new dotfile if requested
            if kwargs['banner']:
                bannerMaker = BannerMaker(text=kwargs['banner'])
                bannerMaker.adorn()
                dotfile.write('%s' % bannerMaker)
                # add a newline
                dotfile.write('\n')

if __name__=='__main__':
    mainObj = Main()
    mainObj.main()
