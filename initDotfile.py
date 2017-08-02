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

    # abs path to the dotfile.d directory
    dotfiledPath = os.path.join(thisPath, 'dotfile.d')

    def initParser(self):
        parser = ArgumentParserInitDotfile(description='This script creates a new dotfile, including a filetype=bash modeline for vim and an optional banner.')

        parser.add_argument('name',                          help='The new dotfile will be created at %s.' % os.path.join(self.dotfiledPath, '<name>'))
        parser.add_argument('-b', '--banner',                help='[optional] A string that will be converted to ascii art and used as a header in the new dotfile.')
        parser.add_argument('-m', '--modeline',
                            default=self.modelineDefault,    help="Modeline that tells vim how to highlight the new dotfile's text.")

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
        initPath = os.path.join(self.dotfiledPath, kwargs['name'])

        # don't allow overwriting of existing dotfile (for now don't allow any overwriting at all, may be relaxed in future)
        if os.path.isfile(initPath) or os.path.isdir(initPath):
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

if __name__=='__main__':
    mainObj = Main()
    mainObj.main()
