from ConfigParser import NoOptionError, NoSectionError, SafeConfigParser
from optparse import OptionParser
from os.path import expanduser

def print_attribute(filename, profile, attribute, list_attributes=False):
    '''return aws attributes'''
    try:
        parser = SafeConfigParser()
        parser.read(filename)
        if list_attributes:
            print 'Available options:'
            for option in parser.options(profile):
                print '\t{}'.format(option)
        else:
            print parser.get(profile, attribute) 
    except NoOptionError:
        print "No attribute '{}' in profile: '{}'".format(attribute, profile)
    except NoSectionError:
        print "No profile '{}' in file '{}'".format(profile, filename)

if __name__ == '__main__':
    parser = OptionParser()
    parser.add_option('-f', '--filename', dest='filename', 
                      help='credential file location',
                      default='{}/.aws/credentials'.format(expanduser('~')))
    parser.add_option('-p', '--profile', dest='profile', 
                      help='credential profile',
                      default='default')
    parser.add_option('-a', '--attribute', dest='attribute', 
                      help='attribute to grab')
    parser.add_option('-l', '--list', dest='list', action='store_true',
                      help='list attributes in profile',
                      default=False)

    (options, args) = parser.parse_args()
    if not options.attribute and not options.list:
            parser.error('attribute must be provided')
    print_attribute(filename=options.filename, 
                    profile=options.profile, 
                    attribute=options.attribute,
                    list_attributes=options.list)
